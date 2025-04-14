//
//  Data.swift
//
//  Created by Hammad Shaikh on 2025-03-20.
//
//  This class represents a customer order in the SwiftBites application.
//  Principal author: Hammad Shaikh

import UIKit

class Order {
    /// Unique identifier for the order
    var id: Int?
    
    /// Email of the user who placed the order
    var userEmail: String?
    
    /// Total price of the order
    var orderTotal: Double?
    
    /// String containing details about the order
    var orderDetails: String?
    
    /// Date when the order was placed
    var orderDate: String?
    
    /// Default initializer
    init() { }
    
    /// Initialize with order data
    /// - Parameters:
    ///   - theRow: Order identifier
    ///   - userEmail: Email of the user
    ///   - orderTotal: Total price
    ///   - orderDetails: Order details
    ///   - orderDate: Date of the order
    func initWithData(theRow: Int, userEmail: String, orderTotal: Double, orderDetails: String, orderDate: String) {
        self.id = theRow
        self.userEmail = userEmail
        self.orderTotal = orderTotal
        self.orderDetails = orderDetails
        self.orderDate = orderDate
    }
}
