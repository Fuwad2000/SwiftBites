
import UIKit

class PaymentViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate {
    
    
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    var menu: [String: [String: [String: Any]]] = Menu.getMenu()?["data"] ?? [:]

    @IBOutlet var subTotalLb: UILabel!
    @IBOutlet var taxLb: UILabel!
    @IBOutlet var totalLb: UILabel!
    @IBOutlet var orderBtn : UIButton!
    
    var subtotal: Double = 0.0
    let email = (UIApplication.shared.delegate as? AppDelegate)?.userEmail ?? "No Email"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("User email: \(email)")
        var subtotal: Double = 0.0
        for (cartId, quantity) in mainDelegate.cart {
            var category = ""
            if cartId.contains("drink") {
                category = "drinks"
            } else if cartId.contains("food") {
                category = "food"
            } else {
                category = "snacks"
            }

            let price = menu[category]?[cartId]?["price"] as? Double ?? 0.0
            subtotal += price * Double(quantity)
        }

        let taxRate = 0.13 // 13% HST (or change based on your region)
        let tax = subtotal * taxRate
        let total = subtotal + tax

        // Display the values in your labels
        subTotalLb.text = String(format: "Subtotal: $%.2f",subtotal)
        taxLb.text = String(format: "Tax: $%.2f", tax)
        totalLb.text = String(format: "Total: $%.2f", total)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.mainDelegate.cart.keys.count
    }
    
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
    
    @IBAction func orderButtonTapped(_ sender: UIButton) {
        // Assuming you have all the data you need: subtotal, tax, total, and other properties.
        
        let timestamp = getCurrentTimestamp() // You can create a function to get the current timestamp.
        
        // Loop through the cart and create OrderItem objects for each item
        for (cartId, quantity) in mainDelegate.cart {
            var category = ""
            if cartId.contains("drink") {
                category = "drinks"
            } else if cartId.contains("food") {
                category = "food"
            } else {
                category = "snacks"
            }
            
            // Get the item details from the menu
            let itemName = menu[category]?[cartId]?["name"] as? String ?? "Item"
            let price = menu[category]?[cartId]?["price"] as? Double ?? 0.0
            let itemId = cartId
            
            // Calculate subtotal, tax, and total
            let subtotal = price * Double(quantity)
            let taxRate = 0.13 // 13% HST (or change based on your region)
            let tax = subtotal * taxRate
            let total = subtotal + tax
            
            
            
            // Initialize the OrderItem object
            let orderItem = OrderItem()
            orderItem.initWithData(
                email: email,
                category: category,
                itemId: itemId,
                itemName: itemName,
                price: price,
                quantity: quantity,
                subtotal: subtotal,
                tax: tax,
                total: total,
                timestamp: timestamp
            )
            
            // Pass the OrderItem object to InsertIntoDatabase
            mainDelegate.insertIntoDatabase(order: orderItem)
        }
    }

    func getCurrentTimestamp() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: Date())
    }
    
    @IBAction func unwindToPaymentVC(_ sender: UIStoryboardSegue) {

    }
    

    

}
