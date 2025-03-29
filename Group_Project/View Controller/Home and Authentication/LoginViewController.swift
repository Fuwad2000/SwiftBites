//
//  LoginViewController.swift
//  Group_Project
//
//  Created by Fuwad Oladega on 2025-03-27.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController,UITextFieldDelegate {

    // MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var togglePasswordVisibilityButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        // Hide error label initially
        errorLabel.isHidden = true
        passwordTextField.isSecureTextEntry = true
    }
    
    @IBAction func togglePasswordVisibility(_ sender: UIButton) {
        // Toggle the secure text entry
        passwordTextField.isSecureTextEntry.toggle()
        
        // Change the button image based on the visibility state
        let buttonImage = passwordTextField.isSecureTextEntry ? UIImage(systemName: "eye.slash") : UIImage(systemName: "eye")
        togglePasswordVisibilityButton.setImage(buttonImage, for: .normal)
    }

    
    @IBAction func unwindToLogin(segue: UIStoryboardSegue) {
       
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       
        return textField.resignFirstResponder()
    }
    
    // MARK: - Actions
    
    // Login button pressed
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
                self?.navigateToHome()
            }
        }
    }

    // MARK: - Helper Methods
    
    // Display an error message
    func displayError(_ message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
    }
    
    // Navigate to the home screen (e.g., main app screen)
    func navigateToHome() {
        if let landingVC = storyboard?.instantiateViewController(identifier: "LandingViewController") {
              landingVC.modalPresentationStyle = .fullScreen // Makes it full screen, avoiding stacked views
              present(landingVC, animated: true) {
                  self.view.window?.rootViewController = landingVC // Removes login from the stack
              }
          }

    }
}
