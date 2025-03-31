//
//  DrinkViewController.swift
//  Group_Project
//
//  Created by Fuwad Oladega on 2025-03-27.
//

import UIKit

class DrinkViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var drinkMenu: [String: [String: Any]] = Menu.getDrinks() ?? [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        drinkMenu.count
    }
    
//
//    // MARK: - Table view data source.
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return orders.count
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "OrderCell") as? SiteCell ?? SiteCell(style: .default, reuseIdentifier: "OrderCell")
        let drinkList = Array(drinkMenu.keys)
        let drinkId = drinkList[indexPath.row]
        
        cell.primaryLabel.text = drinkMenu[drinkId]?["name"] as? String ?? ""
//        : \(order.deliveryDate ?? "")"
        cell.secondaryLabel.text = "Price: \(drinkMenu[drinkId]?["price"] ?? "0")"
        cell.myImageView.image = UIImage(named: drinkMenu[drinkId]?["image"] as? String ?? "")
       
        cell.tintColor = UIColor.black
        cell.setCustomDisclosureIndicator(color: .black)
//        tableView.tintColor = UIColor.red
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let drinkList = Array(drinkMenu.keys)
        let drinkId = drinkList[indexPath.row]
        let message = """
        Name: \(drinkMenu[drinkId]?["name"] as? String ?? "")
        Price: \(drinkMenu[drinkId]?["price"] ?? "0")
        Description \(drinkMenu[drinkId]?["description"] ?? "")
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
