//
//  SignUpViewController.swift
//  IOSAuthTest
//
//  Created by Samuel Villegas on 2022-04-02.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func signUp(_ sender: UIButton) {
        
        guard let email = emailInput.text else {
            return
        }
        
        guard let name = nameInput.text else {
            return
        }
        
        guard let password = passwordInput.text else {
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if authResult != nil {
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                
                changeRequest?.displayName = name
                changeRequest?.commitChanges { error in
                    if(error != nil){
                        print("SignUp Error: \(String(describing:error))")
                    } else {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "privateViewController")
                        
                        self.view.window?.rootViewController = vc
                        self.view.window?.makeKeyAndVisible()
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

}
