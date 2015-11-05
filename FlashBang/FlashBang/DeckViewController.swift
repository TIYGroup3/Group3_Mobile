//
//  DeckViewController.swift
//  FlashBang
//
//  Created by alex oh on 11/4/15.
//  Copyright © 2015 Alex Oh. All rights reserved.
//

import UIKit

class DeckViewController: UIViewController {

    
    @IBOutlet weak var deckTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
//        // if user logged in
//        if USERLOGGEDIN != nil {
//            
//            // logged in
//            
//        } else {
//            
//            // not logged in
//            
//            let storyboardLogin = UIStoryboard(name: "Login", bundle: nil)
//            if let loginVC = storyboardLogin.instantiateInitialViewController() {
//                
//                presentViewController(loginVC, animated: true, completion: nil)
//                
//            }
//            
//        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension DeckViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 2
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
//        let cell = tableView.dequeueReusableCellWithIdentifier("", forIndexPath: indexPath)
//        
//        let message = messages[indexPath.row]
//        
//        cell.textLabel?.text = message["content"] as? String
//        
//        return cell
        
    }

}
