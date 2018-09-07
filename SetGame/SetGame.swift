//
//  Set.swift
//  SetGame
//
//  Created by Admin on 8/26/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

struct SetGame
{
    init() {
        loadCardsFromDeck(countCards: countOfCardsWithSet)
    }
    
    let countOfCardsWithSet = 21
    let countOfCardsInSet = 3
    
    var cards = [Card]()
    var selectedCards = [Card]()
    
    private var deck = CardDeck()
    
    var countOfCardsInDeck: Int {
        get {
            return deck.cards.count + cards.count
        }
    }
    
    var indexesOfFirstSet: [Int]? {
        get {
            return findFirstSet()
        }
    }
    
    mutating func selectCard(index: Int)
    {
        selectedCards.append(cards[index])
    }
    
    mutating func deselectCard(index: Int)
    {
        if let arrayIndex = selectedCards.index(where: {$0 == cards[index]}) {
            selectedCards.remove(at: arrayIndex)
        }
    }
    
    mutating func removeSelectedCards()
    {
        for i in 0..<countOfCardsInSet {
            if let arrayIndex = cards.index(where: {$0 == selectedCards[i]}) {
                cards.remove(at: arrayIndex)
            }
        }
        selectedCards.removeAll()
        
    }
    
    mutating func loadCardsFromDeck(countCards: Int)
    {
        for _ in 1...countCards {
            if let card = deck.draw() {
                cards.append(card)
            }
        }
    }
    
    mutating func unselectAllCards()
    {
        selectedCards.removeAll()
    }
    
    private func findFirstSet() -> [Int]?{
        for i in 0..<cards.count {
            for j in i+1..<cards.count {
                for k in j+1..<cards.count {
                    if isSet(cards: [cards[i], cards[j], cards[k]]) {
                        return [i, j, k]
                    }
                }
            }
        }
        return nil
    }
    
    func isSetSelected() -> Bool {
        return isSet(cards: selectedCards)
    }
    
    func isSet(cards: [Card]) -> Bool {
        if cards.count == countOfCardsInSet {
            
            let firstCard = cards[0]
            let secondCard = cards[1]
            let thirdCard = cards[2]
            let equalQuantity = (firstCard.quantity == secondCard.quantity) && (secondCard.quantity == thirdCard.quantity)
            let notEqualQuantity = (firstCard.quantity != secondCard.quantity) && (firstCard.quantity != thirdCard.quantity) && (secondCard.quantity != thirdCard.quantity)
            let equalColor = (firstCard.color == secondCard.color) && (secondCard.color == thirdCard.color)
            let notEqualColor = (firstCard.color != secondCard.color) && (firstCard.color != thirdCard.color) && (secondCard.color != thirdCard.color)
            let equalProduct = (firstCard.product == secondCard.product) && (secondCard.product == thirdCard.product)
            let notEqualProduct = (firstCard.product != secondCard.product) && (firstCard.product != thirdCard.product) && (secondCard.product != thirdCard.product)
            
            let equalShading = (firstCard.shading == secondCard.shading) && (secondCard.shading == thirdCard.shading)
            let notEqualShading = (firstCard.shading != secondCard.shading) && (firstCard.shading != thirdCard.shading) && (secondCard.shading != thirdCard.shading)
            
            return (equalQuantity || notEqualQuantity) && (equalColor || notEqualColor) && (equalProduct || notEqualProduct) && (equalShading || notEqualShading)
            
        }
        else {
            return false
        }
    }
    
}
