//
//  Card.swift
//  SetGame
//
//  Created by Admin on 8/26/18.
//  Copyright © 2018 Admin. All rights reserved.
//
enum Product {
    case apple
    case pepper
    case tomato
    
    static var all = [Product.apple, .pepper, .tomato]
}

enum ProductColor {
    case red
    case green
    case yellow
    
    static var all = [ProductColor.red, .green, .yellow]
}

enum ProductShading {
    case fill
    case open
    case striped
    
    static var all = [ProductShading.fill, .open, .striped]
}



import Foundation
struct Card: Equatable {
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return (lhs.quantity == rhs.quantity) && (lhs.product == rhs.product) && (lhs.color == rhs.color) && (lhs.shading == rhs.shading)
    }
    
    var quantity: Int
    var product: Product
    var color: ProductColor
    var shading: ProductShading
}
