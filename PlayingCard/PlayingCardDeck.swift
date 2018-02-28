 //
 //  PlayingCardDeck.swift
 //  PlayingCard
 //
 //  Created by Chen Weiru on 28/02/2018.
 //  Copyright © 2018 ChenWeiru. All rights reserved.
 //
 
 import Foundation
 
 struct PlayingCardDeck {
    private(set) var cards = [PlayingCard]()
    
        init() {
            for suit in PlayingCard.Suit.all{
                for rank in PlayingCard.Rank.all{
                    cards.append(PlayingCard(suit: suit, rank: rank))
                }
            }
        }
    
    mutating func draw() -> PlayingCard? {
        if cards.count > 0{
            return  cards.remove(at: cards.count.arc4random)
        }else{
            return nil
        }
    }
 }
 
 extension Int {
    var arc4random: Int {
        if self != 0{
            return Int(arc4random_uniform(UInt32(abs(self))))
        }else{
            return 0
        }
    }
 }
