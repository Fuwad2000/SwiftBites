//
//  SiteCell.swift
//
//  Created by Jawaad Sheikh on 2018-03-14.
//  Copyright © 2018 Jawaad Sheikh. All rights reserved.
//

import UIKit

class SiteCell: UITableViewCell {
    
    let primaryLabel = UILabel()
    let secondaryLabel = UILabel()
    let myImageView = UIImageView()
    let shoppingCartButton: UIButton = {
        let button = UIButton(type: .system)
        if let cartImage = UIImage(systemName: "cart") {
            button.setImage(cartImage, for: .normal)
        }
        button.tintColor = .systemPink
        
        // Make sure user interaction is enabled
        button.isUserInteractionEnabled = true
        
        // Make the tappable area larger
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        return button
    }()
    
    
    let mainDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var cartButtonAction: (() -> Void)?
    
    // Override the constructor
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        // Configure primaryLabel
        primaryLabel.textAlignment = NSTextAlignment.left
        primaryLabel.font = UIFont.boldSystemFont(ofSize: 15)
        primaryLabel.backgroundColor = UIColor.clear
        primaryLabel.textColor = UIColor.black
        
        // Configure secondaryLabel
        secondaryLabel.textAlignment = NSTextAlignment.left
        secondaryLabel.font = UIFont.boldSystemFont(ofSize: 16)
        secondaryLabel.backgroundColor = UIColor.clear
        secondaryLabel.textColor = UIColor.red
        
        // Call super
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Add this to prevent cell selection from interfering with button taps
        self.selectionStyle = .none
        
        // Add subviews to content view
        contentView.addSubview(primaryLabel)
        contentView.addSubview(secondaryLabel)
        contentView.addSubview(myImageView)
        contentView.addSubview(shoppingCartButton)
        
        // Setup the button
        setupCartButton()
    }
    
    // Required initializer
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Setup the cart button
    private func setupCartButton() {
        // Use traditional target-action pattern
        shoppingCartButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        // Debug output
        print("Shopping cart button setup complete")
    }
    
    // Button action handler
    @objc private func buttonTapped() {
        print("Button tapped directly in cell")
        cartButtonAction?()
    }
    
    // Method to set the button action from outside
    func setCartButtonAction(_ action: @escaping () -> Void) {
        self.cartButtonAction = action
        print("Cart button action set")
    }
    
    // Custom disclosure indicator
    func setCustomDisclosureIndicator(color: UIColor) {
        // Create a custom chevron image
        let chevronImage = UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysTemplate)
        let chevronImageView = UIImageView(image: chevronImage)
        chevronImageView.tintColor = color
        
        // Size it appropriately
        chevronImageView.frame = CGRect(x: 0, y: 0, width: 11, height: 14)
        chevronImageView.contentMode = .scaleAspectFit
        
        // Replace the built-in accessory with our custom one
        self.accessoryView = chevronImageView
        self.separatorInset = .zero
        self.layoutMargins = .zero
        
        // This will only affect this specific cell's separator
        if let separatorView = self.subviews.first(where: { $0.frame.height <= 1 && $0.frame.width > self.frame.width/2 }) {
            separatorView.backgroundColor = color
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // Layout subviews
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
        let buttonSize: CGFloat = 44
        
        // Use bounds instead of frame for positioning
        let buttonX = contentView.bounds.width - buttonSize - 20
        
        shoppingCartButton.frame = CGRect(
            x: buttonX,
            y: (contentView.bounds.height - buttonSize) / 2,
            width: buttonSize,
            height: buttonSize
        )
        
        // Debug output
        print("Button position: \(shoppingCartButton.frame), Cell content width: \(contentView.bounds.width)")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
