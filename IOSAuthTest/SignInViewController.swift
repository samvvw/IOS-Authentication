//
//  SignInViewController.swift
//  IOSAuthTest
//
//  Created by Samuel Villegas on 2022-04-02.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    var handle:AuthStateDidChangeListenerHandle?
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener{ auth,user in
            if user != nil {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "privateViewController")
                self.view.window?.rootViewController = vc
                self.view.window?.makeKeyAndVisible()
            } else {
                print("User not found")
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signIn(_ sender: UIButton) {
        guard let email = emailInput.text else {return}
        guard let password = passwordInput.text else {return}
        
        Auth.auth().signIn(withEmail: email, password: password) {
            [weak self] authResult, error in
            if error != nil {
                print("SignIn Error: \(error)")
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
