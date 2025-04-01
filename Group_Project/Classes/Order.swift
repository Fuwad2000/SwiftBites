//
//  Data.swift
//
//  Created by Hammad Shaikh on 2025-03-20.
//

import UIKit

class Order {
    var id: Int?
    var userEmail: String?
    var orderTotal: Double?
    var orderDetails: String?
    var orderDate: String?
    
    init() { }
    
    func initWithData(theRow: Int, userEmail: String, orderTotal: Double, orderDetails: String, orderDate: String) {
        self.id = theRow
        self.userEmail = userEmail
        self.orderTotal = orderTotal
        self.orderDetails = orderDetails
        self.orderDate = orderDate
    }
}
