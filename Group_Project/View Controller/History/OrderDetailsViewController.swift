//
//  OrderDetailsViewController.swift
//  Group_Project
//
//  Created by Fuwad Oladega on 2025-03-27.
//

import UIKit

class OrderDetailsViewController: UIViewController {
    @IBOutlet var orderIdLbl: UILabel!
    @IBOutlet var itemsLbl: UILabel!
    @IBOutlet var subtotalLbl: UILabel!
    @IBOutlet var taxLbl: UILabel!
    @IBOutlet var totalLbl: UILabel!
    @IBOutlet var itemImage: UIImageView!
    
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    var order: [OrderItem] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        order = mainDelegate.selectedOrder
        
        itemImage.image = UIImage(named: "\(order[0].itemId ?? "drink1.jpg").jpg")
        orderIdLbl.text = "Order ID: \(order[0].orderId ?? "")"
        var itemString: String = "Items: "
        for orderItem: OrderItem in order{
            itemString += "\n\(orderItem.itemName ?? "") x \(orderItem.quantity ?? 0) = \(orderItem.price ?? 0.0 * Double(orderItem.quantity ?? 0))"
        }
        itemsLbl.text = itemString
//        print("item string: \(itemsLbl.text)")
        subtotalLbl.text = "Subtotal: \(String(format: "%.2f", order[0].subtotal ?? 0.0))"
        taxLbl.text = "Tax: \(String(format: "%.2f", order[0].tax ?? 0.0))"
        totalLbl.text = "Total: \(String(format: "%.2f", order[0].total ?? 0.0))"
        

        // Do any additional setup after loading the view.
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
