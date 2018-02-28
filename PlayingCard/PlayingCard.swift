//
//  PlayingCard.swift
//  PlayingCard
//
//  Created by Chen Weiru on 28/02/2018.
//  Copyright © 2018 ChenWeiru. All rights reserved.
//

import Foundation

 struct PlayingCard:CustomStringConvertible {
    var description: String {return "\(rank)\(suit)"}
    
     //MARK: Vars
    
    var suit: Suit
    var rank: Rank
    
    //MARK: Enum Suit
    
    enum Suit: String, CustomStringConvertible {
        var description: String
        
        case spades = "♤"
        case hearts = "♡"
        case diamonds = "♢"
        case clubs = "♧"
        
        static var all = [Suit.spades, .hearts, .diamonds, .clubs]
    }
    
     //MARK: Enum Rank
    
    enum  Rank:CustomStringConvertible {
        var description: String
        
        case ace
        case face(String)
        case numeric(Int)
        
        var order:Int{
            switch self {
            case .ace: return 1
            case .numeric(let pips): return pips
            case .face(let kind) where kind == "J": return 11
            case .face(let kind) where kind == "Q": return 12
            case .face(let kind) where kind == "K": return 13
            default: return 0
            }
        }
        
        
            static var all:[Rank] {
                var allRank = [Rank.ace]
                for pips in 2...10{
                    allRank.append(Rank.numeric(pips))
                }
                allRank += [Rank.face("J"), .face("Q"), .face("K")]
                return allRank
            }
        }
        
    }

