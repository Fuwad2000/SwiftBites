//
//  CartViewController.swift
//  Group_Project
//
//  Created by Hammad Shaikh on 2025-03-30.
//
//  This class manages the shopping cart view, showing items and their quantities.
//  Principal author: Hammad Shaikh

import UIKit

class CartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    /// Table view to display cart items
    @IBOutlet var tableView: UITableView!
    
    /// Label to display the total price
    @IBOutlet var totalLbl: UILabel!
    
    /// Reference to app delegate for accessing shared data
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    /// Menu data containing all available items
    var menu: [String: [String: [String: Any]]] = Menu.getMenu()?["data"] ?? [:]
    
    /// Set up the view when loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var total: Double = 0.0
        for key in mainDelegate.cart.keys {
            print(key)
            var idStub = ""
            // Determine the category of the item based on its ID
            if key.contains("drink"){
                idStub = "drinks"
            }
            else if key.contains("food"){
                idStub = "food"
            }
            else {
                idStub = "snacks"
            }
            
            // Calculate the total price by multiplying item price by quantity
            let price = menu[idStub]?[key]?["price"] as? Double ?? 0.0
            total += price * Double(mainDelegate.cart[key] ?? 1)
        }
        
        // Format and display the total price
        totalLbl.text = "Total: $\(String(format: "%.2f", total))"
    }
    
    /// Unwind segue handler when returning to the cart view
    /// - Parameter sender: The segue being unwound
    @IBAction func unwindToCart(_ sender: UIStoryboardSegue) {
        
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
        return 80
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
}
