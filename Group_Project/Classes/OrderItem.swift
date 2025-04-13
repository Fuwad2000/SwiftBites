//
//  OrderItem.swift
//  Group_Project
//
//  Created by Muhammad Bilal Arshad on 2025-04-05.
//

import UIKit

class OrderItem: NSObject {
    var email: String?
    var category: String?
    var itemId: String?
    var itemName: String?
    var price: Double?
    var quantity: Int?
    var subtotal: Double?
    var tax: Double?
    var total: Double?
    var timestamp: String?
    var orderId: String?
    
    // Initialize with data from the database
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
