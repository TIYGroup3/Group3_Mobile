//
//  LoginViewController.swift
//  FlashBang
//
//  Created by alex oh on 11/4/15.
//  Copyright © 2015 Alex Oh. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var fullNameField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    
    
    
    @IBAction func loginButton(sender: AnyObject) {
        
        if let username = usernameField.text {
            
            // need to use passwordField
            
            // use username & password to retrieve data from backend
            
        }
        
    }
    
    @IBAction func registerButton(sender: AnyObject) {
        
        
    }
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
