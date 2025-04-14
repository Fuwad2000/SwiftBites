//
//  MenuViewController.swift
//  Group_Project
//
//  Created by Hammad Shaikh on 2025-03-31.
//
//  This class manages the menu display and allows users to browse and add items to their cart.
//  Principal author: Hammad Shaikh

import UIKit

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITabBarDelegate {
    /// Count of items in the cart for badge display
    var cartCount: Int = 0
    
    /// Current menu items being displayed
    var menu: [String: [String: Any]] = Menu.getDrinks() ?? [:]
    
    /// Table view for displaying menu items
    @IBOutlet var tableView: UITableView!
    
    /// Tab bar for switching between menu categories
    @IBOutlet var tabBar: UITabBar!
    
    /// Button to navigate to the cart with badge showing item count
    @IBOutlet var cartButton: BadgeButton!
    
    /// Reference to app delegate for accessing shared data
    let mainDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    /// Set up the view when loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tabBar.delegate = self
        tabBar.selectedItem = tabBar.items?[0]
    }
    
    /// Returns the number of rows in the table view
    /// - Parameters:
    ///   - tableView: The table view requesting this information
    ///   - section: The section number
    /// - Returns: Number of menu items in the current category
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menu.count
    }
    
    /// Unwind segue handler when returning to the menu screen
    /// - Parameter segue: The segue being unwound
    @IBAction func unwindToMenuViewController(segue: UIStoryboardSegue) {
        
    }
    
    /// Handle tab bar selection to switch between menu categories
    /// - Parameters:
    ///   - tabBar: The tab bar where selection occurred
    ///   - item: The selected tab bar item
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        // Update the menu based on the selected category
        if item.tag == 0 {
            menu = Menu.getDrinks() ?? [:]
        }
        else if item.tag == 1 {
            menu = Menu.getSnacks() ?? [:]
        }
        else{
            menu = Menu.getFood() ?? [:]
        }
        tableView.reloadData()
    }
    
    /// Configures and returns a cell for a particular row
    /// - Parameters:
    ///   - tableView: The table view requesting the cell
    ///   - indexPath: The index path for the cell
    /// - Returns: A configured table view cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "OrderCell") as? SiteCell ?? SiteCell(style: .default, reuseIdentifier: "OrderCell")
        let drinkList = Array(menu.keys)
        let drinkId = drinkList[indexPath.row]
        
        // Configure cell with menu item details
        cell.primaryLabel.text = menu[drinkId]?["name"] as? String ?? ""
        cell.secondaryLabel.text = "Price: \(menu[drinkId]?["price"] ?? "0")"
        cell.myImageView.image = UIImage(named: menu[drinkId]?["image"] as? String ?? "")
       
        cell.tintColor = UIColor.black
        cell.setCustomDisclosureIndicator(color: .black)
        
        // Set up the action for the cart button
        cell.setCartButtonAction { [weak self] in
                guard let self = self else { return }
                
                print("Cart button tapped for item at index \(indexPath.row)")
                
                // Add item to cart or increment quantity if already in cart
                if mainDelegate.cart[drinkId] == nil {
                    mainDelegate.cart[drinkId] = 1
                }
                else{
                    mainDelegate.cart[drinkId]! += 1
                }
                
                // Update cart badge
                cartCount += 1
                cartButton.badgeValue = String(cartCount)
                
                // Show confirmation alert
                let alert = UIAlertController(title: "Added to Cart",
                                              message: "\(cell.primaryLabel.text ?? "") has been added to your cart.",
                                             preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true)
            }
        
        return cell
    }
    
    /// Returns the height for each row in the table view
    /// - Parameters:
    ///   - tableView: The table view requesting this information
    ///   - indexPath: The index path for the row
    /// - Returns: Row height in points
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    /// Handles selection of a row in the table view
    /// - Parameters:
    ///   - tableView: The table view where selection occurred
    ///   - indexPath: The index path of the selected row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let drinkList = Array(menu.keys)
        let drinkId = drinkList[indexPath.row]
        
        // Create and display an alert with the item details
        let message = """
        Name: \(menu[drinkId]?["name"] as? String ?? "")
        Price: \(menu[drinkId]?["price"] ?? "0")
        Description \(menu[drinkId]?["description"] ?? "")
        """
        let alert = UIAlertController(title: "Item Details", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
