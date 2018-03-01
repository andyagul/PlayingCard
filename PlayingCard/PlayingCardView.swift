//
//  PlayingCardView.swift
//  PlayingCard
//
//  Created by Chen Weiru on 01/03/2018.
//  Copyright © 2018 ChenWeiru. All rights reserved.
//

import UIKit

class PlayingCardView: UIView {
    
    var rank:Int = 5 { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var suit:String = "♡"{ didSet { setNeedsDisplay(); setNeedsLayout() } }
    var isFaceUp = true{ didSet { setNeedsDisplay(); setNeedsLayout() } }
    
    private func centeredAttributedString(_ string:String, fontSize:CGFloat) -> NSAttributedString{
        var font = UIFont.preferredFont(forTextStyle: .body) .withSize(fontSize)
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        return NSAttributedString(string: string, attributes: [.paragraphStyle:paragraphStyle, .font:font])
    }
    
    private var connerString: NSAttributedString {
        return centeredAttributedString(rankString + "\n" + suit, fontSize: cornerFontSize )
    }
    
    override func draw(_ rect: CGRect) {
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius:cornerRadius)
        roundedRect.addClip()
        UIColor.white.setFill()
        roundedRect.fill()
        
    }
    
}


extension PlayingCardView{
    private struct SizeRatio{
        static let cornerFontSizeToBoundsHeight: CGFloat = 0.085
        static let cornerRadiusToBoundsHeight:CGFloat = 0.06
        static let cornerOffSetToCornerRadius:CGFloat = 0.33
        static let faceCardImageSizeToBoundsSize:CGFloat = 0.75
    }
    
    private var cornerRadius:CGFloat{
        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
    }
    
    private var connerOffset:CGFloat{
        return cornerRadius * SizeRatio.cornerOffSetToCornerRadius
    }
    
    private var cornerFontSize:CGFloat{
        return bounds.size.height * SizeRatio.cornerFontSizeToBoundsHeight
    }
    
    private var rankString:String{
        switch rank {
        case 1: return "A"
        case 2...10: return String(rank)
        case 11: return "J"
        case 12: return "Q"
        case 13: return "K"
        default: return "?"
        }
    }
    
}


























