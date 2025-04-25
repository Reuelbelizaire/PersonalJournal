//
//  RegisterViewController.swift
//  PersonalJournal
//
//  Created by Belizaire, Reuel James on 4/11/25.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageLabel.text = ""
        // Do any additional setup after loading the view.
    }
    

    @IBAction func registerPressed(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty else {
            messageLabel.text = "Please enter your email."
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            messageLabel.text = "Please enter your password."
            return
        }
        
        //auth() is an example of singleton reference, which is shared by the whole app.
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let e = error {
                print(e)
            } else {
                //Navigate to the TabBarController
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let tabBarController = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController {
                    // Optional: make the transition fullscreen
                    tabBarController.modalPresentationStyle = .fullScreen
                    self.present(tabBarController, animated: true, completion: nil)
                }
                
            }
        }
    }
}
    
    
    


