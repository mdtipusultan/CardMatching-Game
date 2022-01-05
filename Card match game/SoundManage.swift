//
//  SoundManage.swift
//  Card match game
//
//  Created by User on 19/12/21.
//  Copyright © 2021 User. All rights reserved.
//

import Foundation
import AVFoundation

class SoundManager {
    
    var audioPlayer: AVAudioPlayer?
    var soundFileName = ""
    
    enum SoundEffect {
        case flip
        case match
        case notMatch
        case shuffle
    }
    
    func playSound(effect:SoundEffect) {
        
        switch effect {
            
        case .flip:
            soundFileName = "cardflip"
            
        case .match:
            soundFileName = "dingcorrect"
            
        case .notMatch:
            soundFileName = "dingwrong"
            
        case .shuffle:
            soundFileName = "shuffle"
        }
        
        //get the path to the resorce
        let bundlepath = Bundle.main.path(forResource: soundFileName, ofType: ".wav")
        
        //check thats not nil (if statement er moto e but guard mane bujha jai j aikhane check kora hoitese. )
        guard bundlepath != nil else {
            
            // could not fin any resouce, exit
            return
        }
        
        let url = URL(fileURLWithPath:  bundlepath!)
        
        do {
            
            //create the audio player
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            
            //play the sound effect
            audioPlayer?.play()
        }
        catch {
            print("could not creant an audio player")
            return
        }
        
    }
}
