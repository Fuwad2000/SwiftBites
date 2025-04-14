//
//  PaymentViewController.swift
//  Group_Project
//
//  Created by Muhammad Bilal Arshad on 2025-04-01.
//
//  This class manages the payment screen showing order summary and handling checkout process.
//  Principal author: Muhammad Bilal Arshad

import UIKit
import Foundation

class PaymentViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate {
    
    /// Reference to app delegate for accessing shared data
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    /// Menu data containing all available items
    var menu: [String: [String: [String: Any]]] = Menu.getMenu()?["data"] ?? [:]

    /// Label to display subtotal amount
    @IBOutlet var subTotalLb: UILabel!
    
    /// Label to display tax amount
    @IBOutlet var taxLb: UILabel!
    
    /// Label to display total amount
    @IBOutlet var totalLb: UILabel!
    
    /// Button to confirm order
    @IBOutlet var orderBtn : UIButton!
    
    /// Order subtotal before tax
    var subtotal: Double = 0.0
    
    /// Current user's email address
    let email = (UIApplication.shared.delegate as? AppDelegate)?.userEmail ?? "No Email"
    
    /// Set up the view when loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        print("User email: \(email)")
        var subtotal: Double = 0.0
        
        // Calculate subtotal from cart items
        for (cartId, quantity) in mainDelegate.cart {
            var category = ""
            if cartId.contains("drink") {
                category = "drinks"
            } else if cartId.contains("food") {
                category = "food"
            } else {
                category = "snacks"
            }

            let price = menu[category]?[cartId]?["price"] as? Double ?? 0.0
            subtotal += price * Double(quantity)
        }

        // Calculate tax and total
        let taxRate = 0.13 // 13% HST (or change based on your region)
        let tax = subtotal * taxRate
        let total = subtotal + tax

        // Display the values in the labels
        subTotalLb.text = String(format: "$%.2f", subtotal)
        taxLb.text = String(format: "$%.2f", tax)
        totalLb.text = String(format: "$%.2f", total)
    }
    
    /// Returns the number of rows in the table view
    /// - Parameters:
    ///   - tableView: The table view requesting this information
    ///   - section: The section number
    /// - Returns: Number of items in the cart
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.mainDelegate.cart.keys.count
    }
    
    /// Configures and returns a cell for a particular row
    /// - Parameters:
    ///   - tableView: The table view requesting the cell
    ///   - indexPath: The index path for the cell
    /// - Returns: A configured table view cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "OrderCell") as? SiteCell ?? SiteCell(style: .default, reuseIdentifier: "OrderCell")
        let cartKeys = Array(mainDelegate.cart.keys)
        let cartId = cartKeys[indexPath.row]
        
        // Determine the category of the item
        var idStub = ""
        if cartId.contains("drink"){
            idStub = "drinks"
        }
        else if cartId.contains("food"){
            idStub = "food"
        }
        else {
            idStub = "snacks"
        }
        
        // Configure the cell with item details
        cell.primaryLabel.text = menu[idStub]?[cartId]?["name"] as? String ?? "Item"
        cell.secondaryLabel.text = "Price: \(menu[idStub]?[cartId]?["price"] ?? "0") Quantity: \(mainDelegate.cart[cartId] ?? 0)"
        cell.myImageView.image = UIImage(named: menu[idStub]?[cartId]?["image"] as? String ?? "")
       
        cell.tintColor = UIColor.black
        cell.setCustomDisclosureIndicator(color: .black)
        cell.shoppingCartButton.isHidden = true
        
        return cell
    }
    
    /// Returns the height for each row in the table view
    /// - Parameters:
    ///   - tableView: The table view requesting this information
    ///   - indexPath: The index path for the row
    /// - Returns: Row height in points
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    /// Handles selection of a row in the table view
    /// - Parameters:
    ///   - tableView: The table view where selection occurred
    ///   - indexPath: The index path of the selected row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cartKeys = Array(mainDelegate.cart.keys)
        let cartId = cartKeys[indexPath.row]
        
        // Determine the category of the selected item
        var idStub = ""
        if cartId.contains("drink"){
            idStub = "drinks"
        }
        else if cartId.contains("food"){
            idStub = "food"
        }
        else {
            idStub = "snacks"
        }
        
        // Create and display an alert with the item details
        let message = """
        Name: \(menu[idStub]?[cartId]?["name"] as? String ?? "")
        Price: \(menu[idStub]?[cartId]?["price"] ?? "0")
        Description: \(menu[idStub]?[cartId]?["description"] ?? "")
        """
        let alert = UIAlertController(title: "Item Details", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    /// Handles order confirmation and processes the order
    /// - Parameter sender: The button that triggered this action
    @IBAction func orderButtonTapped(_ sender: UIButton) {
        // Generate a timestamp and unique order ID
        let timestamp = getCurrentTimestamp()
        let orderId = UUID().uuidString
        
        // Calculate order totals
        var subtotal = 0.0
        var taxRate = 0.13 // 13% HST
        var tax = 0.0
        var total = 0.0
        
        // Calculate subtotal from all items
        for (cartId, quantity) in mainDelegate.cart {
            var category = ""
            if cartId.contains("drink") {
                category = "drinks"
            } else if cartId.contains("food") {
                category = "food"
            } else {
                category = "snacks"
            }
            
            let price = menu[category]?[cartId]?["price"] as? Double ?? 0.0
            subtotal += price * Double(quantity)
        }
        
        // Calculate tax and total
        total = subtotal * (taxRate + 1)
        tax = subtotal * taxRate
        
        // Create order items for each cart item and save to database
        for (cartId, quantity) in mainDelegate.cart {
            var category = ""
            if cartId.contains("drink") {
                category = "drinks"
            } else if cartId.contains("food") {
                category = "food"
            } else {
                category = "snacks"
            }
            
            // Get the item details from the menu
            let itemName = menu[category]?[cartId]?["name"] as? String ?? "Item"
            let price = menu[category]?[cartId]?["price"] as? Double ?? 0.0
            let itemId = cartId
            
            // Initialize the OrderItem object
            let orderItem = OrderItem()
            orderItem.initWithData(
                email: email,
                category: category,
                itemId: itemId,
                itemName: itemName,
                price: price,
                quantity: quantity,
                subtotal: subtotal,
                tax: tax,
                total: total,
                timestamp: timestamp,
                orderId: orderId
            )
            
            // Save the order item to the database
            mainDelegate.insertIntoDatabase(order: orderItem)
        }
        
        // Clear the cart after successful order
        mainDelegate.cart = [:]
    }

    /// Returns the current date and time formatted as a string
    /// - Returns: Formatted timestamp string
    func getCurrentTimestamp() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: Date())
    }
    
    /// Unwind segue handler when returning to the payment view
    /// - Parameter sender: The segue being unwound
    @IBAction func unwindToPaymentVC(_ sender: UIStoryboardSegue) {

    }
}
