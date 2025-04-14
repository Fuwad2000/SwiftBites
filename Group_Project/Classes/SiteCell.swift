//
//  SiteCell.swift
//  Group_Project
//
//  Created by Jawaad Sheikh on 2018-03-14.
//  Copyright © 2018 Jawaad Sheikh. All rights reserved.
//
//  This class provides a custom table view cell for displaying menu items with images and add-to-cart functionality.
//  Principal author: Jawaad Sheikh

import UIKit

class SiteCell: UITableViewCell {
    
    /// Primary label for displaying item name
    let primaryLabel = UILabel()
    
    /// Secondary label for displaying price and other details
    let secondaryLabel = UILabel()
    
    /// Image view for displaying item image
    let myImageView = UIImageView()
    
    /// Button for adding items to the shopping cart
    let shoppingCartButton: UIButton = {
        let button = UIButton(type: .system)
        if let cartImage = UIImage(systemName: "cart") {
            button.setImage(cartImage, for: .normal)
        }
        button.tintColor = .systemPink
        button.isUserInteractionEnabled = true
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        return button
    }()
    
    /// Reference to app delegate for accessing shared data
    let mainDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    /// Closure to handle cart button taps
    var cartButtonAction: (() -> Void)?
    
    /// Initialize with style and reuse identifier
    /// - Parameters:
    ///   - style: Cell style
    ///   - reuseIdentifier: Reuse identifier for the cell
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        // Configure primaryLabel
        primaryLabel.textAlignment = .left
        primaryLabel.font = UIFont.boldSystemFont(ofSize: 15)
        primaryLabel.backgroundColor = .clear
        primaryLabel.textColor = .black
        
        // Configure secondaryLabel
        secondaryLabel.textAlignment = .left
        secondaryLabel.font = UIFont.boldSystemFont(ofSize: 16)
        secondaryLabel.backgroundColor = .clear
        secondaryLabel.textColor = .red
        
        // Call super
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Prevent cell selection from interfering with button taps
        self.selectionStyle = .none

        // Set background to clear
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        
        // Add subviews
        contentView.addSubview(primaryLabel)
        contentView.addSubview(secondaryLabel)
        contentView.addSubview(myImageView)
        contentView.addSubview(shoppingCartButton)
        
        // Setup the button
        setupCartButton()
    }
    
    /// Required initializer from NSCoder
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Prepare cell for reuse by resetting properties
    override func prepareForReuse() {
        super.prepareForReuse()
        // Ensure transparency remains on reuse
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
    }
    
    /// Set up the cart button with its target action
    private func setupCartButton() {
        shoppingCartButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        print("Shopping cart button setup complete")
    }
    
    /// Handle button tap events
    @objc private func buttonTapped() {
        print("Button tapped directly in cell")
        cartButtonAction?()
    }
    
    /// Set the action to perform when the cart button is tapped
    /// - Parameter action: Closure to execute on button tap
    func setCartButtonAction(_ action: @escaping () -> Void) {
        self.cartButtonAction = action
        print("Cart button action set")
    }
    
    /// Set a custom disclosure indicator with the specified color
    /// - Parameter color: Color for the indicator
    func setCustomDisclosureIndicator(color: UIColor) {
        let chevronImage = UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysTemplate)
        let chevronImageView = UIImageView(image: chevronImage)
        chevronImageView.tintColor = color
        chevronImageView.frame = CGRect(x: 0, y: 0, width: 11, height: 14)
        chevronImageView.contentMode = .scaleAspectFit
        self.accessoryView = chevronImageView
        self.separatorInset = .zero
        self.layoutMargins = .zero
        
        // Find and color the separator line
        if let separatorView = self.subviews.first(where: { $0.frame.height <= 1 && $0.frame.width > self.frame.width / 2 }) {
            separatorView.backgroundColor = color
        }
    }
    
    /// Called when the cell is loaded from a nib
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    /// Position and size the subviews
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var f = CGRect(x: 125, y: 5, width: 460, height: 30)
        primaryLabel.frame = f
        
        f = CGRect(x: 125, y: 40, width: 460, height: 20)
        secondaryLabel.frame = f
        
        f = CGRect(x: 25, y: 5, width: 45, height: 45)
        myImageView.frame = f
        myImageView.layer.cornerRadius = myImageView.frame.size.width / 2
        myImageView.clipsToBounds = true
        myImageView.contentMode = .scaleAspectFill
        
        // Position the shopping cart button on the right side
        let buttonSize: CGFloat = 44
        let buttonX = contentView.bounds.width - buttonSize - 20
        shoppingCartButton.frame = CGRect(
            x: buttonX,
            y: (contentView.bounds.height - buttonSize) / 2,
            width: buttonSize,
            height: buttonSize
        )
        
        print("Button position: \(shoppingCartButton.frame), Cell content width: \(contentView.bounds.width)")
    }
    
    /// Handle cell selection state changes
    /// - Parameters:
    ///   - selected: Whether the cell is selected
    ///   - animated: Whether to animate the selection change
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

