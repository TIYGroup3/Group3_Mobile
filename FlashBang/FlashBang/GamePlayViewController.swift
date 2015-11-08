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
    
    @IBOutlet weak var questionTextField: UITextField!
    
    
    @IBOutlet weak var answerTextField: UITextField!
    
    
    
    @IBAction func playGameButton(sender: AnyObject) {
        // get timer to work
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "countUp", userInfo: nil, repeats: true)
        
    }
    
    @IBAction func enterAnswer(sender: AnyObject) {
        
        if answerTextField.text == questionTextField.text {
            
            
            
        } else {
            
            print(self.allCards)
            self.allCards.removeFirst()
            print(self.allCards)
            
        }
        
    }

    
    @IBOutlet weak var timerLabel: UILabel!
    
    var timer = NSTimer()
    var counter = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionTextField.allowsEditingTextAttributes = false

        
        if let deckID = deckID {
            
            receiveCardsFromDeck(deckID)
            
            
        }
        
        var testCards: ArrayDict = [
            
            
            ["1": "10", "11": "11"],
            ["2": "20"],
            ["3": "30"],
            ["4": "40"],
            ["5": "50"],
            ["6": "60"],
            ["7": "70"],
            ["8": "80"],
            ["9": "90"]
            
            
        ]

        self.allCards = testCards
        
        print(allCards)
        
        let arrayCount = UInt32(testCards.count)
        var randomIndex = Int(arc4random_uniform(arrayCount))
        if randomIndex == 0 {
            
            
        } else {
        
        randomIndex = randomIndex - 1
        
        }
        
        let x = randomIndex
        questionTextField.text = allCards[0]["1"] as? String
        
        self.allCards.removeAtIndex(x)
        
        
    }
    
    func receiveCardsFromDeck(deckID: Int) {
        
        var info = RequestInfo()
        let stringDeckID = String(deckID)
        
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
    
    

}



