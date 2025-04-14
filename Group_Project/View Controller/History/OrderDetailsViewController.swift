//
//  OrderDetailsViewController.swift
//  Group_Project
//
//  Created by Prince Chauhan on 2025-04-05.
//
//  This class displays detailed information about a specific order including items, prices, and totals.
//  Principal author: Prince Chauhan

import UIKit

class OrderDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    /// Label for displaying the order ID
    @IBOutlet var orderIdLbl: UILabel!
    
    /// Label for displaying the subtotal amount
    @IBOutlet var subtotalLbl: UILabel!
    
    /// Label for displaying the tax amount
    @IBOutlet var taxLbl: UILabel!
    
    /// Label for displaying the total amount
    @IBOutlet var totalLbl: UILabel!
    
    /// Image view for displaying an item image
    @IBOutlet var itemImage: UIImageView!
    
    /// Table view for displaying order items
    @IBOutlet var tableView: UITableView!
    
    /// Reference to app delegate for accessing shared data
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    /// The order items to display
    var order: [OrderItem] = []

    /// Set up the view when loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set table view delegates
        tableView.delegate = self
        tableView.dataSource = self
        
        // Register cell if not done in storyboard
        // tableView.register(OrderItemCell.self, forCellReuseIdentifier: "SiteCell")
        
        // Get the order details from the app delegate
        order = mainDelegate.selectedOrder
        
        // Check if order has any items
        guard let firstItem = order.first else {
            // Display default values if order is empty
            orderIdLbl.text = "Order ID: N/A"
            subtotalLbl.text = "Subtotal: $0.00"
            taxLbl.text = "Tax: $0.00"
            totalLbl.text = "Total: $0.00"
            itemImage.image = UIImage(named: "drink1.jpg")
            return
        }

        // Display order information
        let trimmedOrderId = String(firstItem.orderId?.prefix(5) ?? "N/A")
        orderIdLbl.text = "Order ID: #\(trimmedOrderId)"
        
        // Set the item image
        if let itemId = firstItem.itemId {
            itemImage.image = UIImage(named: "\(itemId).jpg")
        } else {
            itemImage.image = UIImage(named: "drink1.jpg")
        }
        itemImage.contentMode = .scaleAspectFill
        
        // Display order totals
        subtotalLbl.text = "Subtotal: $\(String(format: "%.2f", firstItem.subtotal ?? 0.0))"
        taxLbl.text = "Tax: \(String(format: "%.2f", firstItem.tax ?? 0.0))"
        totalLbl.text = "Total: $\(String(format: "%.2f", firstItem.total ?? 0.0))"
    }

    /// Returns the number of rows in the table view
    /// - Parameters:
    ///   - tableView: The table view requesting this information
    ///   - section: The section number
    /// - Returns: Number of items in the order
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return order.count
    }

    /// Configures and returns a cell for a particular row
    /// - Parameters:
    ///   - tableView: The table view requesting the cell
    ///   - indexPath: The index path for the cell
    /// - Returns: A configured table view cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? OrderItemCell else {
            return UITableViewCell()
        }

        // Get the order item for this row
        let orderItem = order[indexPath.row]
        let quantity = orderItem.quantity ?? 0
        let price = orderItem.price ?? 0.0
        let total = price * Double(quantity)
        
        // Configure the cell with item details
        cell.nameLabel.text = orderItem.itemName ?? ""
        cell.quantityLabel.text = "x\(quantity)"
        cell.totalLabel.text = "$\(String(format: "%.2f", total))"
        
        return cell
    }
}

