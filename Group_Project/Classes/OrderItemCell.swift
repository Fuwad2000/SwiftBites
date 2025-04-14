//
//  OrderItemCell.swift
//  Group_Project
//
//  Created by Muhammad Bilal Arshad on 2025-04-02.
//
//  This class provides a custom table view cell for displaying order item details.
//  Principal author: Muhammad Bilal Arshad

import UIKit

class OrderItemCell: UITableViewCell {
    
    // MARK: - IBOutlets
    /// Label for displaying the item name
    @IBOutlet weak var nameLabel: UILabel!
    
    /// Label for displaying the item quantity
    @IBOutlet weak var quantityLabel: UILabel!
    
    /// Label for displaying the total price
    @IBOutlet weak var totalLabel: UILabel!
    
    /// Reference width for iPhone 16 screen (6.9" display)
    private let iPhone16ScreenWidth: CGFloat = 428
    
    // MARK: - Layout
    /// Position and size the subviews
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Using hardcoded positions to ensure consistent layout on iPhone 16
        nameLabel.frame = CGRect(x: 20, y: 15, width: iPhone16ScreenWidth * 0.5, height: 20)
        quantityLabel.frame = CGRect(x: iPhone16ScreenWidth * 0.55, y: 15, width: 40, height: 20)
        totalLabel.frame = CGRect(x: iPhone16ScreenWidth * 0.8, y: 15, width: iPhone16ScreenWidth * 0.2, height: 20)
    }
}
