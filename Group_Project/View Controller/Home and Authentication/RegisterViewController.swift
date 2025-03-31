import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController,UITextFieldDelegate {

    // MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var togglePasswordVisibilityButton: UIButton!
    @IBOutlet weak var toggleCPasswordVisibilityButton: UIButton!

    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
        confirmPasswordTextField.isSecureTextEntry = true
        
        
        
        // Hide error label initially
        errorLabel.isHidden = true
    }
    
    @IBAction func togglePasswordVisibility(_ sender: UIButton) {
        // Toggle the secure text entry
        passwordTextField.isSecureTextEntry.toggle()
        
        // Change the button image based on the visibility state
        let buttonImage = passwordTextField.isSecureTextEntry ? UIImage(systemName: "eye.slash") : UIImage(systemName: "eye")
        togglePasswordVisibilityButton.setImage(buttonImage, for: .normal)
    }
    
    @IBAction func toggleCPasswordVisibility(_ sender: UIButton) {
        // Toggle the secure text entry
        confirmPasswordTextField.isSecureTextEntry.toggle()
        
        // Change the button image based on the visibility state
        let buttonImage =  confirmPasswordTextField.isSecureTextEntry ? UIImage(systemName: "eye.slash") : UIImage(systemName: "eye")
        toggleCPasswordVisibilityButton.setImage(buttonImage, for: .normal)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       
        return textField.resignFirstResponder()
    }
    // MARK: - Actions
    
    
    
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty else {
            displayError("Please fill in all fields.")
            return
        }
        
       
        if password != confirmPassword {
            displayError("Passwords do not match.")
            return
        }
        
        // MARK: - Actions

        // Action for the toggle visibility button
        

        
      
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.displayError("Registration failed: \(error.localizedDescription)")
                    print(error.localizedDescription)
                } else {
                    self?.mainDelegate.userEmail = email
                    self?.navigateToHome()
                
                    // TODO: Setup local SQLite database.
                    // - Create an "AddToCart" table linked to the user's email.
                    // - Create an "Order" table where each order is associated with an email.
                    // - Create an "OrderItems" table, linked to the "Order" table (One-to-Many).

                }
            }
        }
    }
    
    // MARK: - Helper Methods
    
    // Display an error message
    func displayError(_ message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
    }
    
    
    func navigateToHome() {
        if let landingVC = storyboard?.instantiateViewController(identifier: "LandingViewController") {
              landingVC.modalPresentationStyle = .fullScreen // Makes it full screen, avoiding stacked views
              present(landingVC, animated: true) {
                  self.view.window?.rootViewController = landingVC // Removes login from the stack
              }
          }

    }
}

