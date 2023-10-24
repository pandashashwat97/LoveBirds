//
//  RegisterViewController.swift
//  LoveBirds
//
//  Created by Shashwat Panda on 02/01/23.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UITextField!
    
    @IBOutlet weak var passwordLabel: UITextField!
    var crud = CRUD()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        
        //coreData saving sender name
        crud.saveName(entitySelected: "SName", name: userNameLabel.text ?? "NA")
        
        //Registering with firebase
        if let email = userNameLabel.text,
           let password = passwordLabel.text {
            Auth.auth().createUser(withEmail: email,
                                   password: password){ [weak self]
                firebaseResult, error in
                if let e = error {
                    print(e.localizedDescription)
                }else{
                   self?.performSegue(withIdentifier: K.registerSegue, sender: self)
                }
            }
        }
    }
    
}
