//
//  BadgeButton.swift
//  Group_Project
//
//  Created by Hammad Shaikh on 2025-03-25.
//
//  This class creates a custom button with a notification badge for displaying item counts.
//  Principal author: Hammad Shaikh

import UIKit

class BadgeButton: UIButton {
    
    /// A UILabel that serves as the notification badge
    lazy var badgeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .red
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.layer.cornerRadius = 10 // For a circular badge
        label.clipsToBounds = true
        label.isHidden = true  // Hide by default
        return label
    }()
    
    /// The value displayed in the badge, setting this updates the badge appearance
    var badgeValue: String? {
        didSet {
            updateBadge()
        }
    }
    
    /// Called when the view is loaded from the storyboard
    override func awakeFromNib() {
        super.awakeFromNib()
        setupBadge()
    }
    
    /// Adds the badge label as a subview and sets its constraints
    private func setupBadge() {
        addSubview(badgeLabel)
        NSLayoutConstraint.activate([
            // Position the badge at the top-right corner of the button
            badgeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: -5),
            badgeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 5),
            badgeLabel.widthAnchor.constraint(equalToConstant: 20),
            badgeLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    /// Updates the badge's appearance based on badgeValue
    private func updateBadge() {
        if let text = badgeValue, !text.isEmpty, text != "0" {
            // Only show the badge if there's a non-zero, non-empty value
            badgeLabel.text = text
            badgeLabel.isHidden = false
        } else {
            badgeLabel.isHidden = true
        }
    }
}
