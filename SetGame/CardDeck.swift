//
//  CardDeck.swift
//  SetGame
//
//  Created by Admin on 8/27/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
struct CardDeck {
    
    private(set) var cards = [Card]()
    
    init() {
        for product in Product.all {
            for color in ProductColor.all {
                for shading in ProductShading.all {
                    for quantity in 1...3 {
                        cards.append(Card(quantity: quantity, product: product, color: color, shading: shading))
                        
                    }
                }
            }
        }
    }
    
    mutating func draw() -> Card? {
        if cards.count > 0 {
            return cards.remove(at: cards.count.arc4random)
        } else {
            return nil
        }
    }
    
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
