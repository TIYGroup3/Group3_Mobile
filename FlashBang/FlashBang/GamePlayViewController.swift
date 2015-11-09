//
//  GamePlayViewController.swift
//  FlashBang
//
//  Created by alex oh on 11/4/15.
//  Copyright © 2015 Alex Oh. All rights reserved.
//

import UIKit


class GamePlayViewController: UIViewController {

    var deckID: Int?
    
    var allCards: ArrayDict = []
    
    var cardID: Int?

    @IBOutlet weak var ImageView: UIImageView!
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    
    @IBOutlet weak var numberOfCardsLeft: UILabel!
    
    
    @IBOutlet weak var numberOfStars: UILabel!
    
    
    @IBOutlet weak var playButtonOutlet: UIButton!
    @IBAction func playGameButton(sender: AnyObject) {
        // get timer to work
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "countUp", userInfo: nil, repeats: true)
        
        changeCards()
        
        playButtonOutlet.enabled = false
        
        enterOutlet.enabled = true
    }
    
    @IBOutlet weak var enterOutlet: UIButton!
    @IBAction func enterAnswer(sender: AnyObject) {
        
        if answerTextField.text?.lowercaseString == questionTextField.text?.lowercaseString {
            
            timer.invalidate()
            
            var timeStamp = counter
            
            if let cardID = self.cardID {
                
                postUserGuesses(cardID, duration: timeStamp, correct: true)
                
                print(timeStamp)
                print(cardID)
            }
            
            
            
            // MARK: ????
            
            changeCards()
            
            counter = 0
            
            timerLabel.text = String(counter)
            
            timer.fire()
            
//            while 1 == 1 {
//                
//                countUp()
//                
//            }
//            
        } else {
            
            
            
            timer.invalidate()
            
            var timeStamp = counter
            
            if let cardID = self.cardID {
                
                postUserGuesses(cardID, duration: timeStamp, correct: false)
                
                print(timeStamp)
                print(cardID)
            }
            
            ImageView.image = UIImage(named: "Bang")
            ImageView.startAnimating()
            changeCards()
            
            counter = 0
            timerLabel.text = String(counter)
            
            timer.fire()
            
//            while 1 == 1 {
//                
//                countUp()
//                
//            }
            
            
        }
        
    }
    
    @IBOutlet weak var starButton: UIButton!
    
    @IBAction func addStar(sender: AnyObject) {
        
        // MARK: ????
        
        print(self.deckID)
        if let deckID = self.deckID {
            
            addStar(deckID)
            starButton.alpha = 0
            
        }
        
    }
    
    @IBOutlet weak var timerLabel: UILabel!
    
    var timer = NSTimer()
    var counter = 0
    
    func countUp() {
        
        timerLabel.text = String(counter++)

        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionTextField.allowsEditingTextAttributes = false
        enterOutlet.enabled = false

        // MARK: ????
        numberOfCardsLeft.text = String(self.allCards.count)
        
        
        if let deckID = self.deckID {
            
            receiveCardsFromDeck(deckID)
            getStars(deckID)
        
        }
        
  
        
    }
    
    func changeCards() {
        
        let arrayCount = UInt32(allCards.count)
        var randomIndex = Int(arc4random_uniform(arrayCount))
        if randomIndex == 0 {
            
            
        } else {
            
            randomIndex = randomIndex - 1
            
        }
        
        let x = randomIndex
        
        if allCards.isEmpty == true {
            
            enterOutlet.enabled = false
            
        } else {
        
        questionTextField.text = allCards[x]["front"] as? String
        self.cardID = allCards[x]["id"] as? Int
        self.allCards.removeAtIndex(x)
        
        }
        
    }
    
    func receiveCardsFromDeck(deckID: Int) {
        
        var info = RequestInfo()
        var stringDeckID = String(deckID)
        
        info.endpoint = "/decks/\(stringDeckID)/cards"

        
        info.method = .GET
        info.query = [
        
            ":id": deckID
        
        ]
        
        RailsRequest.session().requestWithInfo(info) { (returnedInfo) -> () in
            
            if let cards = returnedInfo?["cards"] as? ArrayDict {
                
                self.allCards = cards

                
            }
            
            
        }
        
    }
    
    func postUserGuesses(cardID: Int, duration: Int, correct: Bool) {
        
        var info = RequestInfo()
        var stringCardID = String(cardID)
        
        info.endpoint = "/cards/\(stringCardID)/guess"
        
        info.method = .POST

        info.parameters = [
        
            "duration": duration,
            "corrent": correct
        
        ]
        
        RailsRequest.session().requestWithInfo(info) { (returnedInfo) -> () in
            
            print(returnedInfo?["success"])
            
        }
        
    }
    
    func getStars(deckID: Int) {
        
        var info = RequestInfo()
        var stringDeckID = String(deckID)
        
        info.endpoint = "/decks/\(stringDeckID)/stars"
        info.method = .GET
        
        RailsRequest.session().requestWithInfo(info) { (returnedInfo) -> () in
            
            if let stars = returnedInfo?["stars"] as? [String:AnyObject] {
                
                self.numberOfStars.text = stars["count"] as? String
                
                print(stars)
                
            }
            
        }
        
    }
    
    func addStars(deckID: Int) {
        
        var info = RequestInfo()
        var stringDeckID = String(deckID)
        
        info.endpoint = "/decks/\(stringDeckID)/cards"
        info.method = .POST
        
        RailsRequest.session().requestWithInfo(info) { (returnedInfo) -> () in
            
            if let success = returnedInfo?["success"] as? String {
            print(success)
            }
            
        }
        
    }
    

}



