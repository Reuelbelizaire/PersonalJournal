//
//  LoginViewController.swift
//  PersonalJournal
//
//  Created by Belizaire, Reuel James on 4/11/25.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageLabel.text = ""
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty else {
            messageLabel.text = "Please enter your email."
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            messageLabel.text = "Please enter your password."
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let e = error {
                self.messageLabel.text = e.localizedDescription
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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

