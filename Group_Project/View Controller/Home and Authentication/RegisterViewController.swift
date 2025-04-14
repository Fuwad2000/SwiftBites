//
//  RegisterViewController.swift
//  Group_Project
//
//  Created by Fuwad Oladega on 2025-03-27.
//
//  This class handles user registration and account creation.
//  Principal author: Fuwad Oladega

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController, UITextFieldDelegate {

    // MARK: - Outlets
    /// Text field for user's email input
    @IBOutlet weak var emailTextField: UITextField!
    
    /// Text field for user's password input
    @IBOutlet weak var passwordTextField: UITextField!
    
    /// Text field for confirming password input
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    /// Button to submit registration information
    @IBOutlet weak var registerButton: UIButton!
    
    /// Label to display error messages
    @IBOutlet weak var errorLabel: UILabel!
    
    /// Button to toggle password visibility
    @IBOutlet weak var togglePasswordVisibilityButton: UIButton!
    
    /// Button to toggle confirm password visibility
    @IBOutlet weak var toggleCPasswordVisibilityButton: UIButton!

    /// Reference to app delegate for accessing shared data
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    /// Set up the view when loaded
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
    
    /// Toggle password field visibility
    /// - Parameter sender: The button that triggered this action
    @IBAction func togglePasswordVisibility(_ sender: UIButton) {
        // Toggle the secure text entry
        passwordTextField.isSecureTextEntry.toggle()
        
        // Change the button image based on the visibility state
        let buttonImage = passwordTextField.isSecureTextEntry ? UIImage(systemName: "eye.slash") : UIImage(systemName: "eye")
        togglePasswordVisibilityButton.setImage(buttonImage, for: .normal)
    }
    
    /// Toggle confirm password field visibility
    /// - Parameter sender: The button that triggered this action
    @IBAction func toggleCPasswordVisibility(_ sender: UIButton) {
        // Toggle the secure text entry
        confirmPasswordTextField.isSecureTextEntry.toggle()
        
        // Change the button image based on the visibility state
        let buttonImage = confirmPasswordTextField.isSecureTextEntry ? UIImage(systemName: "eye.slash") : UIImage(systemName: "eye")
        toggleCPasswordVisibilityButton.setImage(buttonImage, for: .normal)
    }
    
    /// Dismiss keyboard when return is pressed
    /// - Parameter textField: The active text field
    /// - Returns: Whether the text field should resign first responder status
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    // MARK: - Actions
    
    /// Handle user registration when the register button is pressed
    /// - Parameter sender: The button that triggered this action
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty else {
            displayError("Please fill in all fields.")
            return
        }
        
        // Validate that passwords match
        if password != confirmPassword {
            displayError("Passwords do not match.")
            return
        }
        
        // Create the user account with Firebase
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
    
    /// Display an error message to the user
    /// - Parameter message: The error message to display
    func displayError(_ message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
    }
    
    /// Navigate to the landing screen after successful registration
    func navigateToHome() {
        if let landingVC = storyboard?.instantiateViewController(identifier: "LandingViewController") {
            landingVC.modalPresentationStyle = .fullScreen // Makes it full screen, avoiding stacked views
            present(landingVC, animated: true) {
                // Remove register view from the stack to prevent back navigation
                self.view.window?.rootViewController = landingVC
            }
        }
    }
}

