//
//  PrivateViewController.swift
//  IOSAuthTest
//
//  Created by Samuel Villegas on 2022-04-02.
//

import UIKit
import Firebase

class PrivateViewController: UIViewController {
    @IBOutlet weak var nameOutput: UILabel!
    @IBOutlet weak var emailOutput: UILabel!
    
    var handle: AuthStateDidChangeListenerHandle?
    
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            if user == nil {
                
                let storyboard =  UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "navigationController")
                
                self.view.window?.rootViewController = vc
                self.view.window?.makeKeyAndVisible()
            } else {
                self.nameOutput.text = user?.displayName
                self.emailOutput.text = user?.email
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
    

    @IBAction func logOut(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError)")
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
