//
//  SpriteKitHelper.swift
//  CoinCollector
//
//  Created by Kevin Jusino on 11/8/22.
//

import Foundation
import SpriteKit

enum Layer: CGFloat{
    case background
    case foreground
    case player
    case collectible
    case collectibleb
    case ui
}

// SpriteKit Physics Categories
enum PhysicsCategory{
    static let none: UInt32 = 0
    static let player: UInt32 = 0b1 // 1 - player
    static let collectible: UInt32 = 0b10 // 2 - coin
    static let collectibleb: UInt32 = 0b100 // 3 - bomber
    static let foreground: UInt32 = 0b1000 // 4 - foreground
}
