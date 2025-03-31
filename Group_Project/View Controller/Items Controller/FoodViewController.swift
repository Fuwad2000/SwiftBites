//
//  FoodViewController.swift
//  Group_Project
//
//  Created by Fuwad Oladega on 2025-03-27.
//

import UIKit

class FoodViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var foodMenu: [String: [String: Any]] = Menu.getFood() ?? [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        foodMenu.count
    }
    
//
//    // MARK: - Table view data source.
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return orders.count
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "OrderCell") as? SiteCell ?? SiteCell(style: .default, reuseIdentifier: "OrderCell")
        let foodList = Array(foodMenu.keys)
        let foodId = foodList[indexPath.row]
        
        cell.primaryLabel.text = foodMenu[foodId]?["name"] as? String ?? ""
//        : \(order.deliveryDate ?? "")"
        cell.secondaryLabel.text = "Price: \(foodMenu[foodId]?["price"] ?? "0")"
        cell.myImageView.image = UIImage(named: foodMenu[foodId]?["image"] as? String ?? "")
       
        cell.tintColor = UIColor.black
        cell.setCustomDisclosureIndicator(color: .black)
//        tableView.tintColor = UIColor.red
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let foodList = Array(foodMenu.keys)
        let foodId = foodList[indexPath.row]
        let message = """
        Name: \(foodMenu[foodId]?["name"] as? String ?? "")
        Price: \(foodMenu[foodId]?["price"] ?? "0")
        Description \(foodMenu[foodId]?["description"] ?? "")
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
