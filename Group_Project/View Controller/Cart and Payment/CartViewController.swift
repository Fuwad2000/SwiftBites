

import UIKit

class CartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var totalLbl: UILabel!
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    var menu: [String: [String: [String: Any]]] = Menu.getMenu()?["data"] ?? [:]
    override func viewDidLoad() {
        
        super.viewDidLoad()
        var total: Double = 0.0
        for key in mainDelegate.cart.keys {
            print(key)
            var idStub = ""
            if key.contains("drink"){
                idStub = "drinks"
            }
            else if key.contains("food"){
                idStub = "food"
            }
            else {
                idStub = "snacks"
            }
            let price = menu[idStub]?[key]?["price"] as? Double ?? 0.0
//            if let price = priceString {
            total += price * Double(mainDelegate.cart[key] ?? 1)
//            print("total incremented: \(priceString)")
//            }
        }
        totalLbl.text = "Total: $\(String(format: "%.2f", total))"

        // Do any additional setup after loading the view.
    }
    @IBAction func unwindToCart(_ sender: UIStoryboardSegue) {
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.mainDelegate.cart.keys.count
    }
    
//
//    // MARK: - Table view data source.
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return orders.count
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "OrderCell") as? SiteCell ?? SiteCell(style: .default, reuseIdentifier: "OrderCell")
        let cartKeys = Array(mainDelegate.cart.keys)
        let cartId = cartKeys[indexPath.row]
        var idStub = ""
        if cartId.contains("drink"){
            idStub = "drinks"
        }
        else if cartId.contains("food"){
            idStub = "food"
        }
        else {
            idStub = "snacks"
        }
        cell.primaryLabel.text = menu[idStub]?[cartId]?["name"] as? String ?? "Item"
//        : \(order.deliveryDate ?? "")"
        cell.secondaryLabel.text = "Price: \(menu[idStub]?[cartId]?["price"] ?? "0") Quantity: \(mainDelegate.cart[cartId] ?? 0)"
        cell.myImageView.image = UIImage(named: menu[idStub]?[cartId]?["image"] as? String ?? "")
       
        cell.tintColor = UIColor.black
        cell.setCustomDisclosureIndicator(color: .black)
        cell.shoppingCartButton.isHidden = true

//        tableView.tintColor = UIColor.red
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cartKeys = Array(mainDelegate.cart.keys)
        let cartId = cartKeys[indexPath.row]
        var idStub = ""
        if cartId.contains("drink"){
            idStub = "drinks"
        }
        else if cartId.contains("food"){
            idStub = "food"
        }
        else {
            idStub = "snacks"
        }
        let message = """
        Name: \(menu[idStub]?[cartId]?["name"] as? String ?? "")
        Price: \(menu[idStub]?[cartId]?["price"] ?? "0")
        Description: \(menu[idStub]?[cartId]?["description"] ?? "")
        """
        let alert = UIAlertController(title: "Item Details", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    

   

}
