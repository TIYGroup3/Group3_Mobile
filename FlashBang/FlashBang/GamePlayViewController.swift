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
    
    var currentCard: String?

    
    @IBOutlet weak var correctOrIncorrectView: UIView!
    
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
        
        print(answerTextField.text)
        print(currentCard)
            if answerTextField.text?.lowercaseString == currentCard!.lowercaseString {
                
                timer.invalidate()
                
                var timeStamp = counter
                
                if let cardID = self.cardID {
                    
                    postUserGuesses(cardID, duration: timeStamp, correct: true)
                    
                    print(timeStamp)
                    print(cardID)
                }
                
                correctOrIncorrectView.backgroundColor = UIColor.greenColor()
                
                
                changeCards()
                
                counter = 0
                
                timerLabel.text = String(counter)
                
                timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "countUp", userInfo: nil, repeats: true)
                
                answerTextField.text = ""
                
                
                if allCards.isEmpty == true {
                    
                    timer.invalidate()
                    counter = 0
                    timerLabel.text = String(counter)
                    
                }
            
            
        } else {
            
    
            
            timer.invalidate()
            
            var timeStamp = counter
            
            if let cardID = self.cardID {
                
                postUserGuesses(cardID, duration: timeStamp, correct: false)
                
                print(timeStamp)
                print(cardID)
            }
            
//            ImageView.image = UIImage(named: "Bang")

            correctOrIncorrectView.backgroundColor = UIColor.redColor()
            
            
            changeCards()
            
            counter = 0
            timerLabel.text = String(counter)
            
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "countUp", userInfo: nil, repeats: true)
            
            answerTextField.text = ""
            
            if allCards.isEmpty == true {
                
                timer.invalidate()
                counter = 0
                timerLabel.text = String(counter)
                
            }
            
            print(allCards)

        }
        
    }
    
    @IBOutlet weak var starButton: UIButton!
    
    @IBAction func addStar(sender: AnyObject) {
        
        
        print(self.deckID)
        
        if let deckID = self.deckID {
            
            addStars(deckID)
            starButton.alpha = 0
            getStars(deckID)
            
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
            
            timer.invalidate()
            counter = 0
            timerLabel.text = String(counter)
            enterOutlet.enabled = false
            print("done")
            
        } else {
            
        questionTextField.text = allCards[x]["front"] as? String
        self.cardID = allCards[x]["id"] as? Int
        self.allCards.removeAtIndex(x)
        numberOfCardsLeft.text = String(self.allCards.count)
            
        self.currentCard = allCards[x]["back"] as? String

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
        
        info.endpoint = "/decks/\(stringDeckID)/stars"
        info.method = .POST
        
        RailsRequest.session().requestWithInfo(info) { (returnedInfo) -> () in
            
            if let success = returnedInfo?["success"] as? String {
            print(success)
            }
            
        }
        
    }

}



