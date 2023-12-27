//
//  SignupViewController.swift
//  DR_Demo
//
//  Created by Mohit Pareek on 27/12/23.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var emailTxtField: UITextField!
    
    @IBOutlet weak var passwordTxtFiled: UITextField!
    
    @IBOutlet weak var letsGoBtn: UIButton! {
        didSet {
            letsGoBtn.layer.cornerRadius = 8
            letsGoBtn.layer.borderColor = UIColor.black.cgColor
            letsGoBtn.layer.borderWidth = 0.5
            letsGoBtn.isEnabled = false
        }
        
    }
    
    // MARK: - Intializers
    init() {
        super.init(nibName: Constants.Signup.viewController, bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTxtFields()
        // Do any additional setup after loading the view.
    }

    private func setupTxtFields() {
        emailTxtField.delegate = self
        passwordTxtFiled.delegate = self
    }

}

// MARK: - UITextfield

extension SignupViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        validateCredentials()
    }
    
    func validateCredentials() {
            guard let email = emailTxtField.text, let password = passwordTxtFiled.text else {
                // Handle invalid input
                return
            }

            // Perform your validation logic for email and password
        if email.isValidEmailAddress() && password.isPasswordValid() {
                // Valid credentials, you can proceed with further actions
            letsGoBtn.isEnabled = true
                print("Valid email and password")
            } else {
                // Invalid credentials, display an error message or take appropriate action
                print("Invalid email or password")
            }
        }

}
