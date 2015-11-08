//
//  DeckViewController.swift
//  FlashBang
//
//  Created by alex oh on 11/4/15.
//  Copyright © 2015 Alex Oh. All rights reserved.
//

import UIKit

class DeckViewController: UIViewController {

    var mineOwner: String?
    var mineDeckTitle: String?
    var mineDeck_ID: Int?
    
    var allOwner: String?
    var allDeckTitle: String?
    var allDeck_ID: Int?

    var mineDecks: ArrayDict = []
    var allDecks: ArrayDict = []
    
    @IBOutlet weak var deckTableView: UITableView!
    
    enum OwnerType: String {
        
        case All = "all", Mine = "mine"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        deckTableView.dataSource = self
        deckTableView.delegate = self
  
        
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
        
        receiveDecks(.All)
        receiveDecks(.Mine)
        
    }
    
    func receiveDecks(owner: OwnerType) {
        
        var info = RequestInfo()
        
        info.endpoint = "/decks"
        info.method = .GET
        info.query = [ /// number 2
            "owner": owner.rawValue
        ]
        
        
        RailsRequest.session().requestWithInfo(info) { (returnedInfo) -> () in
            
            
            if owner == .Mine {
                
                if let decks = returnedInfo?["decks"] as? ArrayDict {
                    
                    //                var deckCount = 0
                    
                    print(decks.count)
                    
                    self.mineDecks = decks
                    
                    self.deckTableView.reloadData()
                    
//                    for deck in decks {
//                        
//                        if let id = deck["id"] as? Int {
//                            
//                            self.mineDeck_ID = id
//                            
//                            
//                            
//                        }
//                        
//                        if let title = deck["title"] as? String {
//                            
//                            self.mineDeckTitle = title
//                            
//                        }
//                        
//                        if let owner = deck["owner"] as? String {
//                            
//                            self.mineOwner = owner
//                            
//                        }
//                        
//                    }
                    
                }
                
            } else {
                
                if let decks = returnedInfo?["decks"] as? ArrayDict {
                    
                    self.allDecks = decks
                    
                    print(decks.count)
                    
                    self.deckTableView.reloadData()
                    
//                    for deck in decks {
//                        
//                        if let id = deck["id"] as? Int {
//                            
//                            self.allDeck_ID = id
//                            
//                        }
//                        
//                        if let title = deck["title"] as? String {
//                            
//                            self.allDeckTitle = title
//                            
//                        }
//                        
//                        if let owner = deck["owner"] as? String {
//                            
//                            self.allOwner = owner
//                            
//                        }
//                        
//                    }
                    
                }

                
            }
            
        }
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        guard let cell = sender as? UITableViewCell else {return}
        
        guard let gameVC = segue.destinationViewController as? GamePlayViewController else {return}
        
        guard let indexPath = deckTableView.indexPathForCell(cell) else {return}
        
        if indexPath.section == 0 {
            
            var deckDictionary = mineDecks[indexPath.row]
            gameVC.deckID = deckDictionary["id"] as? Int
            
        } else {
            
            var deckDictionary = allDecks[indexPath.row]
            gameVC.deckID = deckDictionary["id"] as? Int
            
        }
        
    }
    
}
  




extension DeckViewController: UITableViewDataSource, UITableViewDelegate {

    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 40
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return section == 0 ? "My Decks" : "All Decks"
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 2
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return section == 0 ? mineDecks.count : allDecks.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("MineCell", forIndexPath: indexPath)
            
            let deck = mineDecks[indexPath.row]
            
            cell.textLabel?.text = deck["title"] as? String
            
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("AllCell", forIndexPath: indexPath)
            
            
            let deck = allDecks[indexPath.row]
            
            cell.textLabel?.text = deck["title"] as? String
            
            return cell
            
        }
    }
    
}
