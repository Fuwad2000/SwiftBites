//
//  SnackViewController.swift
//  Group_Project
//
//  Created by Fuwad Oladega on 2025-03-27.
//

import UIKit

class SnackViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var snackMenu: [String: [String: Any]] = Menu.getSnacks() ?? [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        snackMenu.count
    }
    
//
//    // MARK: - Table view data source.
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return orders.count
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "OrderCell") as? SiteCell ?? SiteCell(style: .default, reuseIdentifier: "OrderCell")
        let snackList = Array(snackMenu.keys)
        let snackId = snackList[indexPath.row]
        
        cell.primaryLabel.text = snackMenu[snackId]?["name"] as? String ?? ""
//        : \(order.deliveryDate ?? "")"
        cell.secondaryLabel.text = "Price: \(snackMenu[snackId]?["price"] ?? "0")"
        cell.myImageView.image = UIImage(named: snackMenu[snackId]?["image"] as? String ?? "")
       
        cell.tintColor = UIColor.black
        cell.setCustomDisclosureIndicator(color: .black)
//        tableView.tintColor = UIColor.red
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let snackList = Array(snackMenu.keys)
        let snackId = snackList[indexPath.row]
        let message = """
        Name: \(snackMenu[snackId]?["name"] as? String ?? "")
        Price: \(snackMenu[snackId]?["price"] ?? "0")
        \(snackMenu[snackId]?["description"] ?? "")
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
