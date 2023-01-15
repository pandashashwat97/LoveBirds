//
//  LoginViewController.swift
//  LoveBirds
//
//  Created by Shashwat Panda on 02/01/23.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    
    @IBOutlet weak var userNameLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func loginPressed(_ sender: UIButton) {
        
        if let email = userNameLabel.text, let password = passwordLabel.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                }else{
                    self.performSegue(withIdentifier: K.loginSegue, sender: self)
                }
                
                
            }
        }
        
    }
    

}
