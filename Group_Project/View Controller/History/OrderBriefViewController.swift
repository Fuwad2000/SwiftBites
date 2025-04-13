//
//  OrderBriefViewController.swift
//  Group_Project
//
//  Created by Fuwad Oladega on 2025-03-27.
//

import UIKit

class OrderBriefViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet var tableView: UITableView!
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    var orderItems: [OrderItem] = []
    var orders: [String: [OrderItem]] = [:]
    
    @IBAction func clearTable(_ sender: Any) {
        mainDelegate.clearOrdersTable()
        orders.removeAll()
        reloadOrders()
        tableView.reloadData()
    }

    func reloadOrders() {
        // Re-filter the updated mainDelegate.orders
        orderItems = mainDelegate.orders.filter { order in
            order.email == mainDelegate.userEmail
        }
        
        // Because we just called 'orders.removeAll()' above, the dictionary is empty now.
        // Refill it:
        for orderItem in orderItems {
            let key = orderItem.orderId ?? ""
            if orders[key] != nil {
                orders[key]?.append(orderItem)
            } else {
                orders[key] = [orderItem]
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainDelegate.readDataFromDatabase()
        orderItems = mainDelegate.orders.filter { order in
            order.email == mainDelegate.userEmail
        }
        
        for orderItem in orderItems{
            if (orders[orderItem.orderId ?? ""] != nil) {
                orders[orderItem.orderId ?? ""]?.append(orderItem)
            }
            else{
                orders[orderItem.orderId ?? ""] = [orderItem]
            }
        }
        print(orders)
        
        let bgImage = UIImageView(image: UIImage(named: "table.jpg"))
        bgImage.contentMode = .scaleAspectFill
        tableView.backgroundView = bgImage
        tableView.tintColor = UIColor.white
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        orders.count
    }
    @IBAction func unwindToOrders(segue: UIStoryboardSegue) {
       
    }
    
//
//    // MARK: - Table view data source.
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return orders.count
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "OrderCell") as? SiteCell ?? SiteCell(style: .default, reuseIdentifier: "OrderCell")
        let orderKey = Array(orders.keys)[indexPath.row]
        
        cell.primaryLabel.text = "Order Total: $\(String(format: "%.2f", orders[orderKey]?[0].total ?? 0.0))"
//        : \(order.deliveryDate ?? "")"
        cell.secondaryLabel.text = orders[orderKey]?[0].timestamp ?? ""
        cell.myImageView.image = UIImage(named: "\(orders[orderKey]?[0].itemId ?? "drink1").jpg")
        cell.shoppingCartButton.isHidden = true
       
        cell.tintColor = UIColor.white
        cell.setCustomDisclosureIndicator(color: .white)
        tableView.tintColor = UIColor.red
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let orderKey = Array(orders.keys)[indexPath.row]
        mainDelegate.selectedOrder = orders[orderKey] ?? []
        
        self.performSegue(withIdentifier: "details", sender: Any?.self)
        
//        var message = """
//        Order ID: \(orders[orderKey]?[0].orderId ?? "")
//        Items:
//        """
//        for orderItem: OrderItem in orders[orderKey] ?? []{
//            message.append(contentsOf: "\n\(orderItem.itemName ?? "") x \(orderItem.quantity ?? 0): \(orderItem.price ?? 0.0 * Double(orderItem.quantity ?? 0))")
//        }
//        message.append(contentsOf: "\nSubtotal: \(String(format: "%.2f", orders[orderKey]?[0].subtotal ?? 0.0))")
//        message.append(contentsOf: "\nTax: \(String(format: "%.2f", orders[orderKey]?[0].tax ?? 0.0))")
//        message.append(contentsOf: "\nTotal: \(String(format: "%.2f", orders[orderKey]?[0].total ?? 0.0))")
//        
//        let alert = UIAlertController(title: "Order Details", message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//        present(alert, animated: true, completion: nil)
    }
}


