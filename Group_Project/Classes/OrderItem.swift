//
//  OrderItem.swift
//  Group_Project
//
//  Created by Muhammad Bilal Arshad on 2025-04-05.
//
//  This class represents an individual order item in the SwiftBites application.
//  Principal author: Muhammad Bilal Arshad

import UIKit

class OrderItem: NSObject {
    /// User email associated with this order
    var email: String?
    
    /// Food category of the item
    var category: String?
    
    /// Unique identifier for the item
    var itemId: String?
    
    /// Display name of the item
    var itemName: String?
    
    /// Unit price of the item
    var price: Double?
    
    /// Number of this item ordered
    var quantity: Int?
    
    /// Total price before tax
    var subtotal: Double?
    
    /// Tax amount for this item
    var tax: Double?
    
    /// Total price including tax
    var total: Double?
    
    /// When the order was placed
    var timestamp: String?
    
    /// Unique identifier for the order
    var orderId: String?
    
    /// Initialize with data from the database
    /// - Parameters:
    ///   - email: User's email address
    ///   - category: Food category
    ///   - itemId: Item identifier
    ///   - itemName: Name of the item
    ///   - price: Unit price
    ///   - quantity: Number of items
    ///   - subtotal: Price before tax
    ///   - tax: Tax amount
    ///   - total: Final price with tax
    ///   - timestamp: Order time
    ///   - orderId: Order identifier
    func initWithData(email: String, category: String, itemId: String, itemName: String, price: Double, quantity: Int, subtotal: Double, tax: Double, total: Double, timestamp: String, orderId: String) {
        self.email = email
        self.category = category
        self.itemId = itemId
        self.itemName = itemName
        self.price = price
        self.quantity = quantity
        self.subtotal = subtotal
        self.tax = tax
        self.total = total
        self.timestamp = timestamp
        self.orderId = orderId
    }
}
