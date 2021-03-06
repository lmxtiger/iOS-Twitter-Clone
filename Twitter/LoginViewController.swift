//
//  LoginViewController.swift
//  Twitter
//
//  Created by Steven Liu on 11/3/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // When the login page shows up: Check if the user has already logged in
    override func viewDidAppear(_ animated: Bool) {
        if(UserDefaults.standard.bool(forKey: "userLoggedIn") == true) {
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }
    }
    
    @IBAction func onLoginButton(_ sender: Any) {
        let myUrl = "https://api.twitter.com/oauth/request_token"
        TwitterAPICaller.client?.login(url: myUrl, success: {
            
            // Tell the system that the user has logged in 
            UserDefaults.standard.setValue(true, forKey: "userLoggedIn")
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }, failure: { (Error) in
            print("Could NOT log in!")
        })
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
