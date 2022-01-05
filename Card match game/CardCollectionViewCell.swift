//
//  CardCollectionViewCell.swift
//  Card match game
//
//  Created by User on 14/12/21.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var FrontImageView: UIImageView!
    @IBOutlet weak var BackImageView: UIImageView!
    
    var card:Card?
    
    func configureCell (card:Card) {
        
        self.card = card
        
        // Set the font image view to the imagethat represent the card.
        FrontImageView.image = UIImage(named: card.names)
        
        
        if card.isMatching == true {
            
            FrontImageView.alpha = 0
            BackImageView.alpha = 0
            return
        }
            
        else {
            
            FrontImageView.alpha = 1
            BackImageView.alpha = 1
            
        }
        
        if card.isFliped == true {
            
            flipUp(speed: 0)
        }
        else{
            
            flipDown(speed: 0 , delay: 0)
        }
        
    }
    
    func flipUp(speed: TimeInterval = 0.3){
        
        UIView.transition(from: BackImageView, to: FrontImageView, duration: speed, options: [.transitionFlipFromLeft , .showHideTransitionViews], completion: nil)
        
        card?.isFliped = true
        
    }
    
    func flipDown(speed: TimeInterval = 0.3, delay: TimeInterval = 0.5){
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
            
            UIView.transition(from: self.FrontImageView, to: self.BackImageView, duration: speed, options: [.transitionFlipFromLeft , .showHideTransitionViews], completion: nil)
            }
        
        
        card?.isFliped = false
        
    }
    
    func remove(){
        
        BackImageView.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseOut, animations: {
            
            self.FrontImageView.alpha = 0
            
        }, completion: nil)
        
    }
    
}
