//
//  MenuViewController.swift
//  Group_Project
//
//  Created by Hammad Shaikh on 2025-03-31.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITabBarDelegate {
    var cartCount: Int = 0
    var menu: [String: [String: Any]] = Menu.getDrinks() ?? [:]
    @IBOutlet var tableView: UITableView!
    @IBOutlet var tabBar: UITabBar!
    @IBOutlet var cartButton: BadgeButton!
    
    
    let mainDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tabBar.delegate = self
        tabBar.selectedItem = tabBar.items?[0]
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menu.count
    }
    @IBAction func unwindToMenuViewController(segue: UIStoryboardSegue) {
        
    }
    
//
//    // MARK: - Table view data source.
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return orders.count
//    }
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
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
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "OrderCell") as? SiteCell ?? SiteCell(style: .default, reuseIdentifier: "OrderCell")
        let drinkList = Array(menu.keys)
        let drinkId = drinkList[indexPath.row]
        
        cell.primaryLabel.text = menu[drinkId]?["name"] as? String ?? ""
//        : \(order.deliveryDate ?? "")"
        cell.secondaryLabel.text = "Price: \(menu[drinkId]?["price"] ?? "0")"
        cell.myImageView.image = UIImage(named: menu[drinkId]?["image"] as? String ?? "")
       
        cell.tintColor = UIColor.black
        cell.setCustomDisclosureIndicator(color: .black)
        cell.setCartButtonAction { [weak self] in
                guard let self = self else { return }
                
                print("Cart button tapped for item at index \(indexPath.row)")
                
                // self.addToCart(itemAt: indexPath)
//            var quantity_text = ""
                // Show a confirmation to the user
            if mainDelegate.cart[drinkId] == nil {
                mainDelegate.cart[drinkId] = 1
//                quantity_text = "new entry"
            }
            else{
                mainDelegate.cart[drinkId]! += 1
//                quantity_text = "increment"
            }
            cartCount += 1
            cartButton.badgeValue = String(cartCount)
                let alert = UIAlertController(title: "Added to Cart",
                                              message: "\(cell.primaryLabel.text ?? "") has been added to your cart.",
                                             preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true)
            }

//        tableView.tintColor = UIColor.red
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let drinkList = Array(menu.keys)
        let drinkId = drinkList[indexPath.row]
        let message = """
        Name: \(menu[drinkId]?["name"] as? String ?? "")
        Price: \(menu[drinkId]?["price"] ?? "0")
        Description \(menu[drinkId]?["description"] ?? "")
        """
        let alert = UIAlertController(title: "Drink Details", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
