//
//  ViewController.swift
//  PlayingCard
//
//  Created by Chen Weiru on 28/02/2018.
//  Copyright © 2018 ChenWeiru. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var deck = PlayingCardDeck()
    
    
    @IBOutlet var cardViews: [PlayingCardView]!
    
    lazy var animator = UIDynamicAnimator(referenceView: view)
    
    lazy var cardBehavior = CardBehavior(in: animator)
    
    private var faceUpCardViews:[PlayingCardView] {
        return cardViews.filter { $0.isFaceUp
            && $0.isHidden
            && $0.transform != CGAffineTransform.identity.scaledBy(x: 3.0, y: 3.0)
            && $0.alpha == 1
        }
    }
    
    private var faceUpCardViewMatch: Bool{
        return faceUpCardViews.count == 2 &&
            faceUpCardViews[0].rank == faceUpCardViews[1].rank &&
            faceUpCardViews[0].suit == faceUpCardViews[1].suit
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var cards = [PlayingCard]()
        for _ in 1...((cardViews.count+1)/2){
            let card = deck.draw()!
            cards += [card, card]
        }
        for cardView in cardViews{
            cardView.isFaceUp = false
            let card = cards.remove(at: cards.count.arc4random)
            cardView.rank = card.rank.order
            cardView.suit = card.suit.rawValue
            cardView.addGestureRecognizer(UITapGestureRecognizer(target:self, action:#selector(flipCard (_:))))
            cardBehavior.addItem(cardView)
        }
    }
    
    var lastChooseView:PlayingCardView?
    
    
    @objc func flipCard(_ recognizer:UITapGestureRecognizer){
        switch recognizer.state {
        case .ended:
            if let choosenCardView = recognizer.view as? PlayingCardView, faceUpCardViews.count<2{
                lastChooseView = choosenCardView
                cardBehavior.removeItem(choosenCardView)
                UIView.transition(with: choosenCardView,
                                  duration: 0.5,
                                  options: [.transitionFlipFromLeft],
                                  animations: {
                                    choosenCardView.isFaceUp = !choosenCardView.isFaceUp
                },
                                  completion: { finished in
                                    let cardsToAnimate = self.faceUpCardViews
                                    if self.faceUpCardViewMatch{
                                        UIViewPropertyAnimator.runningPropertyAnimator(
                                            withDuration: 0.6,
                                            delay: 0,
                                            options: [],
                                            animations: {
                                                cardsToAnimate.forEach{
                                                    $0.transform = CGAffineTransform.identity.scaledBy(x: 3.0, y: 3.0)
                                                }
                                        },
                                            completion: { posistion in
                                                UIViewPropertyAnimator.runningPropertyAnimator(
                                                    withDuration: 0.75,
                                                    delay: 0,
                                                    options: [],
                                                    animations: {
                                                        cardsToAnimate.forEach{
                                                            $0.transform = CGAffineTransform.identity.scaledBy(x: 3.0, y: 0.1)
                                                            $0.alpha = 0
                                                        }
                                                },
                                                    completion: {
                                                        posistion in
                                                        cardsToAnimate.forEach{
                                                           // $0.removeFromSuperview()
                                                            $0.isHidden = true
                                                            $0.alpha = 1
                                                            $0.transform = .identity
                                                        }
                                                }
                                                    
                                                )
                                                
                                        }
                                        )
                                    }else if cardsToAnimate.count == 2 {
                                        if self.lastChooseView == choosenCardView{
                                        cardsToAnimate.forEach{ cardview in
                                            UIView.transition(with: cardview,
                                                              duration: 0.5,
                                                              options: [.transitionFlipFromLeft],
                                                              animations: {
                                                                cardview.isFaceUp = false
                                            },
                                                              completion:{
                                                                finished in
                                                                    self.cardBehavior.addItem(cardview)
                                            }
                                            )
                                        }
                                    }
                                    }else {
                                        if !choosenCardView.isFaceUp{
                                            self.cardBehavior.addItem(choosenCardView)
                                        }
                                    
                                    }
                                    
                                    
                }
                )
            }
        default:
            break
        }
    }
    
}


extension CGFloat{
    var arc4random:CGFloat{
        if self != 0{
          //  return CGFloat(arc4random_uniform(UInt32(abs(self))))
            print ("Random CGFloat = \(self)")
            return CGFloat(arc4random_uniform(UInt32(self)))

        }else{
            return 0
        }
    }
}

