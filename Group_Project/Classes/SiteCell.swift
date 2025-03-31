//
//  SiteCell.swift
//
//  Created by Jawaad Sheikh on 2018-03-14.
//  Copyright © 2018 Jawaad Sheikh. All rights reserved.
//

import UIKit

class SiteCell: UITableViewCell {
    
    // step 11 - define 2 labels and an image view for our custom cell
    let primaryLabel = UILabel()
    let secondaryLabel = UILabel()
    let myImageView = UIImageView()
    
    // step 11b - override the following constructor
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        // step 11c - configure primaryLabel
        primaryLabel.textAlignment = NSTextAlignment.left
        primaryLabel.font = UIFont.boldSystemFont(ofSize: 15)
        primaryLabel.backgroundColor = UIColor.clear
        primaryLabel.textColor = UIColor.black
        
        // step 11d - configure secondaryLabel
       secondaryLabel.textAlignment = NSTextAlignment.left
        secondaryLabel.font = UIFont.boldSystemFont(ofSize: 16)
        secondaryLabel.backgroundColor = UIColor.clear
        secondaryLabel.textColor = UIColor.red
        
        
        // step 11e - no configuring of myImageView needed, instead add all 3 items manually as below
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(primaryLabel)
        contentView.addSubview(secondaryLabel)
        contentView.addSubview(myImageView)
        
        
    }
    // Add this to your SiteCell class
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
    
    // step 11f - override base constructor to avoid compile error
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // step 11g - define size and location of all 3 items as below
    // return to ChooseSiteViewController.swift
    override func layoutSubviews() {
        
        var f = CGRect(x: 125, y: 5, width: 460, height: 30)
        primaryLabel.frame = f
        
        f = CGRect(x: 125, y: 40, width: 460, height: 20)
        secondaryLabel.frame = f
        
        f = CGRect(x: 25, y: 5, width: 45, height: 45)
        myImageView.frame = f
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

