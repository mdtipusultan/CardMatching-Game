//
//  ViewController.swift
//  Card match game
//
//  Created by User on 12/12/21.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var TimeLevel: UILabel!
    
    @IBOutlet weak var CollectionView: UICollectionView!
    
    
    
    var model = CardModel()
    var cardArray = [Card]()
    var firstCardIndex: IndexPath?
    var timer:Timer?
    var milliseconds:Int = 20*1000
    var soundPlayer: SoundManager = SoundManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //jei cardmodelclass ache tar access aikhn theke nilam
        cardArray = model.cardModel()
        
        //most important line that they are calling that there are self. mane ai viewcontroller e tader function ache.
        CollectionView.delegate = self
        CollectionView.dataSource = self
        
        
        //
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
        
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    //ai function ta karon shuffle sound ta suna jate sathe sathe ase. didload e load hoite time nibe tai problem.
    override func viewDidAppear(_ animated: Bool) {
        
        //shuffle sound
        soundPlayer.playSound(effect: .shuffle)
    }
    
    //MARK:- TIMER METHODS
    @objc func timerFired() {
        
        //decrases the time
        milliseconds -= 1
        
        //update the lable
        let second:Double = Double(milliseconds)/1000.0
        TimeLevel.text = String(format: "Time Remaning: %.2f", second)
        
        // stop the timer if it reaches to 0
        if milliseconds == 0 {
            TimeLevel.textColor = UIColor.red
            timer?.invalidate()
            
            //check for all cards match or not
            checkForEnd()
        }
        else {
            
            //check its all card matching or not
            
        }
        
    }
    
    
    
    //MARK:- using delegate methods (1. koita cell banabo 2. cell er bhitor ki item thakbe and seta kon cell e thakbe)
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //get a cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        // return the cell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let cardCell = cell as? CardCollectionViewCell
        
        // get the card from card array
        let card = cardArray [indexPath.row]
        
        
        // customize the cell
        cardCell?.configureCell(card: card)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //check for if time is end then exit everything
        if milliseconds <= 0{
            
            return
        }
        let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell
        
        if cell?.card?.isFliped == false && cell?.card?.isMatching == false{
            
            cell?.flipUp()
            //shuffle sound
            soundPlayer.playSound(effect: .flip)
            
        }
        
        if firstCardIndex == nil {
            
            //first card is fliped
            firstCardIndex = indexPath
        }
        else {
            
            //this means second card will open now
            
            //check those card are match or not
            
            cardMatch(indexPath)
        }
        
        
    }
    
    //MARK:- Card matching logic
    
    func cardMatch(_ secondCardIndex: IndexPath) {
        
        //card 2 ta re nimu
        let cardOne = cardArray[firstCardIndex!.row]
        let cardTwo = cardArray[secondCardIndex.row]
        
        //create objects to access in cardcollectionview
        let firstCardCell = CollectionView.cellForItem(at: firstCardIndex!)as? CardCollectionViewCell
        let secondCardCell = CollectionView.cellForItem(at: secondCardIndex) as? CardCollectionViewCell
        
        // match hoi kina check korum
        if cardOne.names == cardTwo.names {
            
            //matching sound
            soundPlayer.playSound(effect:.match)
            
            // set the status
            cardOne.isMatching = true
            cardTwo.isMatching = true
            
            // vanish the cards
            firstCardCell?.remove()
            secondCardCell?.remove()
            
            //all cards are matched or not
            //checkForEnd()
            
        }
        else {
            
            //shuffle sound
            soundPlayer.playSound(effect: .notMatch)
            
            // if not match then set status and flip back the cards
            cardOne.isFliped = false
            cardTwo.isFliped = false
            
            firstCardCell?.flipDown()
            secondCardCell?.flipDown()
        }
        
        // set the first card to the initial state
        firstCardIndex = nil
    }
    
    func checkForEnd () {
        
        var haswon = true
        //
        for card in cardArray {
            
            if card.isMatching == false {
                
                haswon = false
                break
            }
        }
        
        if haswon == true {
            // show the win alert
            showAlert(title: "Congratulaton!", message: "You Win!")
        }
            
        else {
            
            //not win yet check for time remain or not
            if milliseconds <= 0 {
                //show the loosing alert
                showAlert(title: "Sorry!", message: "Try for the next time!")
            }
        }
    }
    
    func showAlert (title:String, message:String) {
        
        //create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        //create the delete button after alert
        let action = UIAlertAction(title: "OkAY!", style: .default, handler: nil)
        
        alert.addAction(action)
        
        //show the alert
        present(alert, animated: true, completion: nil)
    }
    
}





