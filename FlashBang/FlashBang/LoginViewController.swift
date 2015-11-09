//
//  LoginViewController.swift
//  FlashBang
//
//  Created by alex oh on 11/4/15.
//  Copyright © 2015 Alex Oh. All rights reserved.
//

import UIKit

typealias ArrayDict = [[String:AnyObject]]

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var fullNameField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    
    
    
    @IBAction func loginButton(sender: AnyObject) {
        
        let usernameRequest = RailsRequest.session()
                
        guard let username = usernameField.text where !username.isEmpty else {return}
        guard let password = passwordField.text where !password.isEmpty else {return}
        
        usernameRequest.loginWithUsername(username, andPassword: password)
        
        // MARK: ???
        
        if RailsRequest.session().user_id != nil {
            
            let gameVC = self.storyboard!.instantiateViewControllerWithIdentifier("gameVC") as! UIViewController
            self.presentViewController(gameVC, animated: true, completion: nil)
            
        }
        
        
    }
    
    @IBAction func registerButton(sender: AnyObject) {
        
        let registerRequest = RailsRequest.session()
        
        guard let username = usernameField.text where !username.isEmpty else {return}
        guard let password = passwordField.text where !password.isEmpty else {return}
        guard let fullName = fullNameField.text where !fullName.isEmpty else {return}
        guard let email = emailField.text where !email.isEmpty else {return}
        
        registerRequest.registerWithUsername(username, FullName: fullName, Email: email, Password: password)
        
        if RailsRequest.session().user_id != nil {
            
            let gameVC = self.storyboard!.instantiateViewControllerWithIdentifier("gameVC") as! UIViewController
            self.presentViewController(gameVC, animated: true, completion: nil)
            
        }
        
    }
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
