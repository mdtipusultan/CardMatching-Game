//
//  classmodel.swift
//  Card match game
//
//  Created by User on 14/12/21.
//  Copyright © 2021 User. All rights reserved.
//

import Foundation

class CardModel {
    
    func cardModel () -> [Card] {
        
        //Declar an empty array to store number
        var generatedNumbers = [Int]()
        
        //create an empty array
        var generatedCards = [Card]()
        
        // create 8 pair of cards using randomnumber
        while generatedNumbers.count < 8 {
            
            //create a randomnumber
            let randomNumber = Int.random(in: 1...13)
            
            if generatedNumbers.contains(randomNumber) == false{
            
            //create two objects of card
            let cardOne = Card()
            let cardTwo = Card()
            
            // randomize the card name
            cardOne.names = "card\(randomNumber)"
            cardTwo.names = "card\(randomNumber)"
            
            //add it in the array
            generatedCards += [cardOne,cardTwo]
            
                // add this number to the list of generated numbers
            generatedNumbers.append(randomNumber)
                
            print(randomNumber)
        }
        }
        
        // randomize the array using shuffle
        generatedCards.shuffle()
        // return the array
        return generatedCards
        
    }
}
