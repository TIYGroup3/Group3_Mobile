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
        enum owner: String {
            
            case all, mine
            
        }
        
        
        func receiveDecks(owner: owner) {
            
            var info = RequestInfo()
            
            info.endpoint = "/decks"
            info.method = .GET
            info.parameters = [
                
                "owner": owner.rawValue
                
            ]
            
            
            RailsRequest.session().requestWithInfo(info) { (returnedInfo) -> () in
                
                if let decks = returnedInfo?["decks"] as? [[String:AnyObject]] {
                    
                    
                    for deck in decks {
                        
                        
                    }
                    
                    //                if let deckID = deck["deck_id"] as? Int {
                    //
                    //                    self.deck_id = deckID
                    //
                    //                }
                    //
                    //                if let owner = deck["deck_id"] as? String {
                    //
                    //                    self.owner = owner
                    //
                    //                }
                    //
                    //                if let userID = deck["deck_id"] as? Int {
                    //
                    //                    self.user_id = userID
                    //                    
                    //                }
                    //                
                    //                if let title = deck["deck_id"] as? String {
                    //                    
                    //                    self.title = title
                    //                    
                    //                }
                    
                }
                
            }
            
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    
    
    
    
    

}
/*

extension DeckViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 2
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return 2
//        return section == 0 ? array1.count : array2.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            // array1
            
            //        let cell = tableView.dequeueReusableCellWithIdentifier("", forIndexPath: indexPath)
            //
            //        cell.textLabel?.text = message["content"] as? String
            //        cell.textLabel?.text = users[indexPath.row].username

            
            //        return cell
            
        } else {
            
            // array2
            
            //        let cell = tableView.dequeueReusableCellWithIdentifier("", forIndexPath: indexPath)
            //
            //        cell.textLabel?.text = message["content"] as? String
            //        cell.textLabel?.text = users[indexPath.row].username

            
            //        return cell
            
        }


    }
    

}

*/
