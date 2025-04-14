//
//  LoginViewController.swift
//  Group_Project
//
//  Created by Fuwad Oladega on 2025-03-27.
//
//  This class handles user authentication and login functionality.
//  Principal author: Fuwad Oladega

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {

    // MARK: - Outlets
    /// Text field for user's email input
    @IBOutlet weak var emailTextField: UITextField!
    
    /// Text field for user's password input
    @IBOutlet weak var passwordTextField: UITextField!
    
    /// Button to submit login credentials
    @IBOutlet weak var loginButton: UIButton!
    
    /// Label to display error messages
    @IBOutlet weak var errorLabel: UILabel!
    
    /// Button to toggle password visibility
    @IBOutlet weak var togglePasswordVisibilityButton: UIButton!

    /// Reference to the app delegate for accessing shared data
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate

    /// Set up the view when loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        // Hide error label initially
        errorLabel.isHidden = true
        passwordTextField.isSecureTextEntry = true
    }
    
    /// Toggle password field between visible and hidden text
    /// - Parameter sender: The button that triggered this action
    @IBAction func togglePasswordVisibility(_ sender: UIButton) {
        // Toggle the secure text entry
        passwordTextField.isSecureTextEntry.toggle()
        
        // Change the button image based on the visibility state
        let buttonImage = passwordTextField.isSecureTextEntry ? UIImage(systemName: "eye.slash") : UIImage(systemName: "eye")
        togglePasswordVisibilityButton.setImage(buttonImage, for: .normal)
    }

    /// Unwind segue handler when returning to the login screen
    /// - Parameter segue: The segue being unwound
    @IBAction func unwindToLogin(segue: UIStoryboardSegue) {
       
    }
    
    /// Dismiss keyboard when return is pressed
    /// - Parameter textField: The active text field
    /// - Returns: Whether the text field should resign first responder status
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Resign first responder to dismiss keyboard
        return textField.resignFirstResponder()
    }
    
    // MARK: - Actions
    
    /// Authenticate user when login button is pressed
    /// - Parameter sender: The button that triggered this action
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            displayError("Please enter both email and password.")
            return
        }
        
        // Attempt to sign in with Firebase Authentication
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                self?.displayError("Login failed: \(error.localizedDescription)")
            } else {
                print("authentication passed")
                self?.mainDelegate.userEmail = email
                self?.navigateToHome()
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
    
    /// Navigate to the landing screen after successful login
    func navigateToHome() {
        if let landingVC = storyboard?.instantiateViewController(identifier: "LandingViewController") {
              landingVC.modalPresentationStyle = .fullScreen // Makes it full screen, avoiding stacked views
              present(landingVC, animated: true) {
                  // Remove login from the stack to prevent back navigation
                  self.view.window?.rootViewController = landingVC
              }
          }
    }
}
