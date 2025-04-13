//
//  AppDelegate.swift
//  Group_Project
//
//  Created by Fuwad Oladega on 2025-03-12.
//

import UIKit
import FirebaseCore
import SQLite3

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var userEmail: String? = ""
    var cart: [String: Int] = [:]
    
    var databaseName: String? = "swiftBites.db"
    
    var databasePath: String? = ""
    
    var orders : [OrderItem] = []

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,  .userDomainMask, true)
        
        let documentDir = documentPath[0]
        
        databasePath = documentDir.appending("/" + databaseName!)
        
        checkAndCreateDatabase()
        readDataFromDatabase()
        
        
        
        
        return true
    }
    func clearOrdersTable() -> Bool {
        var db: OpaquePointer? = nil
        var success = true
        
        // Open the database.
        if sqlite3_open(databasePath, &db) == SQLITE_OK {
            // Prepare the DELETE SQL statement.
            let deleteStatementString = "DELETE FROM order_items"
            var deleteStatement: OpaquePointer? = nil
            
            if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK {
                // Execute the statement.
                if sqlite3_step(deleteStatement) != SQLITE_DONE {
                    if let errorPointer = sqlite3_errmsg(db) {
                        let errorMessage = String(cString: errorPointer)
                        print("Error deleting rows: \(errorMessage)")
                    }
                    success = false
                }
            } else {
                print("DELETE statement could not be prepared")
                success = false
            }
            
            // Clean up and close the database.
            sqlite3_finalize(deleteStatement)
            sqlite3_close(db)
        } else {
            print("Unable to open database.")
            success = false
        }
        readDataFromDatabase()
        return success
    }
    
    
    func insertIntoDatabase(order: OrderItem) -> Bool {
        var db: OpaquePointer? = nil
        var returnCode: Bool = true
        
        if sqlite3_open(databasePath, &db) == SQLITE_OK {
            print("Successfully opened connection")
            
            var insertStatement: OpaquePointer? = nil
            
            // Adjusted query to insert into the orders table with the relevant columns
            let insertStatementString: String = "INSERT INTO order_items (email, category, item_id, item_name, price, quantity, subtotal, tax, total, timestamp, order_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
            
            if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
                // Binding the values from the order parameter
                let email = order.email! as NSString
                let category = order.category! as NSString
                let itemId = order.itemId! as NSString
                let itemName = order.itemName! as NSString
                let price = order.price!
                let quantity = order.quantity!
                let subtotal = order.subtotal!
                let tax = order.tax!
                let total = order.total!
                let timestamp = order.timestamp! as NSString
                let orderId = order.orderId! as NSString
                
                // Binding parameters for the INSERT statement
                sqlite3_bind_text(insertStatement, 1, email.utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 2, category.utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 3, itemId.utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 4, itemName.utf8String, -1, nil)
                sqlite3_bind_double(insertStatement, 5, price)
                sqlite3_bind_int(insertStatement, 6, Int32(quantity))
                sqlite3_bind_double(insertStatement, 7, subtotal)
                sqlite3_bind_double(insertStatement, 8, tax)
                sqlite3_bind_double(insertStatement, 9, total)
                sqlite3_bind_text(insertStatement, 10, timestamp.utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 11, orderId.utf8String, -1, nil)

                
                // Execute the statement
                if sqlite3_step(insertStatement) == SQLITE_DONE {
                    let rowID = sqlite3_last_insert_rowid(db)
                    print("Successfully inserted row with row ID: \(rowID)")
                } else {
                    print("Could not insert row")
                    returnCode = false
                }
                sqlite3_finalize(insertStatement)
            } else {
                let errorMessage = String(cString: sqlite3_errmsg(db))
                print("Error preparing INSERT statement: \(errorMessage)")
                returnCode = false
            }
            sqlite3_close(db)
        } else {
            print("Unable to open database")
            returnCode = false
        }
        
        return returnCode
    }
    
    
    
    
    
    
    func readDataFromDatabase(){
        orders.removeAll()  // Clear previous data
        
        var db : OpaquePointer? = nil
        
        // Open database
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK{
            print("Successfully connected to database at \(databasePath!)")
            
            var queryStatement : OpaquePointer? = nil
            
            // Adjusted query for the order_items table (selecting everything from order_items)
            let queryStatementString : String = "SELECT * FROM order_items"
            
            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK{
                while(sqlite3_step(queryStatement) == SQLITE_ROW){
                    // Mapping the columns to the variables
                    let email = String(cString: sqlite3_column_text(queryStatement, 0))
                    let category = String(cString: sqlite3_column_text(queryStatement, 1))
                    let itemId = String(cString: sqlite3_column_text(queryStatement, 2))
                    let itemName = String(cString: sqlite3_column_text(queryStatement, 3))
                    let price = sqlite3_column_double(queryStatement, 4)
                    let quantity = sqlite3_column_int(queryStatement, 5)
                    let subtotal = sqlite3_column_double(queryStatement, 6)
                    let tax = sqlite3_column_double(queryStatement, 7)
                    let total = sqlite3_column_double(queryStatement, 8)
                    let timestamp = String(cString: sqlite3_column_text(queryStatement, 9))
                    let orderId = String(cString: sqlite3_column_text(queryStatement, 10))
                    
                    // Initialize the OrderItem object with the retrieved data
                    let orderItem = OrderItem()
                    orderItem.initWithData(
                        email: email,
                        category: category,
                        itemId: itemId,
                        itemName: itemName,
                        price: price,
                        quantity: Int(quantity),
                        subtotal: subtotal,
                        tax: tax,
                        total: total,
                        timestamp: timestamp,
                        orderId: orderId
                    )
                    
                    // Add the orderItem to the orderItems array
                    orders.append(orderItem)
                    
                    // Print to verify
                    print("QueryResult: \(email) - \(category) - \(itemId) - \(itemName) - \(price) - \(quantity) - \(subtotal) - \(tax) - \(total) - \(timestamp) - \(orderId)")
                }
                
                sqlite3_finalize(queryStatement)  // Finalize the query
                
            } else {
                let errorMessage = String(cString: sqlite3_errmsg(db))
                print("Error preparing SELECT statement: \(errorMessage)")
            }
        } else {
            print("Unable to open database")
        }
    }
    
    
    
    
    
    
    
    
    
    func checkAndCreateDatabase() {
        
        var success = false
        
        let fileManager = FileManager.default
        
        success = fileManager.fileExists(atPath: databasePath!)
        
        if(success){
            return
        }
        
        let databasePathFromApp = Bundle.main.resourcePath?.appending("/" + databaseName!)
        
        
        try? fileManager.copyItem(atPath: databasePathFromApp!, toPath: databasePath!)
        
        return
    }
    
    

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}

