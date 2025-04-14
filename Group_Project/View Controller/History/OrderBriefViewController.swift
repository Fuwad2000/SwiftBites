//
//  OrderBriefViewController.swift
//  Group_Project
//
//  Created by Prince Chauhan on 2025-03-27.
//
//  This class manages the order history view, displaying past orders for the current user.
//  Principal author: Prince Chauhan

import UIKit

class OrderBriefViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    /// Table view to display order history
    @IBOutlet var tableView: UITableView!
    
    /// Reference to app delegate for accessing shared data
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    /// Collection of order items for the current user
    var orderItems: [OrderItem] = []
    
    /// Dictionary of orders grouped by order ID
    var orders: [String: [OrderItem]] = [:]
    
    /// Sorted keys for displaying orders chronologically
    var sortedOrderKeys: [String] = []
    
    /// Clears all order history from the database
    /// - Parameter sender: The button that triggered this action
    @IBAction func clearTable(_ sender: Any) {
        mainDelegate.clearOrdersTable()
        orders.removeAll()
        reloadOrders()
        tableView.reloadData()
    }

    /// Reloads order data and sorts by timestamp
    func reloadOrders() {
        // Filter orders for the current user
        orderItems = mainDelegate.orders.filter { order in
            order.email == mainDelegate.userEmail
        }
        
        // Group orders by order ID
        for orderItem in orderItems {
            let key = orderItem.orderId ?? ""
            if orders[key] != nil {
                orders[key]?.append(orderItem)
            } else {
                orders[key] = [orderItem]
            }
        }
        
        // Sort order keys by timestamp (newest first)
        sortedOrderKeys = orders.keys.sorted { key1, key2 in
            guard
                let time1 = orders[key1]?[0].timestamp,
                let time2 = orders[key2]?[0].timestamp
            else {
                return false
            }
            return time1 > time2 // Descending order
        }
    }

    /// Set up the view when loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Read orders from database
        mainDelegate.readDataFromDatabase()
        
        // Filter orders for the current user
        orderItems = mainDelegate.orders.filter { order in
            order.email == mainDelegate.userEmail
        }
        
        // Group orders by order ID
        for orderItem in orderItems{
            if (orders[orderItem.orderId ?? ""] != nil) {
                orders[orderItem.orderId ?? ""]?.append(orderItem)
            }
            else{
                orders[orderItem.orderId ?? ""] = [orderItem]
            }
        }
        
        // Process and sort the orders
        reloadOrders()
        
        // Set up background image
        let bgImage = UIImageView(image: UIImage(named: "table.jpg"))
        bgImage.contentMode = .scaleAspectFill
        tableView.backgroundView = bgImage
        tableView.tintColor = UIColor.white
    }
    
    /// Returns the number of rows in the table view
    /// - Parameters:
    ///   - tableView: The table view requesting this information
    ///   - section: The section number
    /// - Returns: Number of orders
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedOrderKeys.count
    }
    
    /// Unwind segue handler when returning to the orders view
    /// - Parameter segue: The segue being unwound
    @IBAction func unwindToOrders(segue: UIStoryboardSegue) {
       
    }
    
    /// Configures and returns a cell for a particular row
    /// - Parameters:
    ///   - tableView: The table view requesting the cell
    ///   - indexPath: The index path for the cell
    /// - Returns: A configured table view cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "OrderCell") as? SiteCell ?? SiteCell(style: .default, reuseIdentifier: "OrderCell")
        let orderKey = sortedOrderKeys[indexPath.row]
        
        // Configure the cell with order details
        cell.primaryLabel.text = "Order Total: $\(String(format: "%.2f", orders[orderKey]?[0].total ?? 0.0))"
        cell.secondaryLabel.text = orders[orderKey]?[0].timestamp ?? ""
        cell.myImageView.image = UIImage(named: "\(orders[orderKey]?[0].itemId ?? "drink1").jpg")
        cell.shoppingCartButton.isHidden = true
       
        cell.tintColor = UIColor.white
        cell.setCustomDisclosureIndicator(color: .white)
        tableView.tintColor = UIColor.red
        
        return cell
    }
    
    /// Returns the height for each row in the table view
    /// - Parameters:
    ///   - tableView: The table view requesting this information
    ///   - indexPath: The index path for the row
    /// - Returns: Row height in points
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    /// Handles selection of a row in the table view
    /// - Parameters:
    ///   - tableView: The table view where selection occurred
    ///   - indexPath: The index path of the selected row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Store the selected order for the detail view
        let orderKey = sortedOrderKeys[indexPath.row]
        mainDelegate.selectedOrder = orders[orderKey] ?? []
        
        // Navigate to the order details screen
        self.performSegue(withIdentifier: "details", sender: Any?.self)
    }
}


