//
//  PhysicsComponent.swift
//  PokemonRPG
//
//  Created by Kevin Jusino on 12/6/22.
//

import SpriteKit
import GameplayKit

enum PhysicsCategory: String {
  case player
  case collectible
  case tree
  case door
}

enum PhysicsShape: String {
  case circle
  case rect
}

struct PhysicsBody: OptionSet, Hashable {
  let rawValue: UInt32
  
  static let player       = PhysicsBody(rawValue: 1 << 0) // Binary   1   -> Dec 1
  static let collectible  = PhysicsBody(rawValue: 1 << 1) // Binary  10  -> Dec 2
  static let tree         = PhysicsBody(rawValue: 1 << 2) // Binary 100 -> Dec 4
  static let door         = PhysicsBody(rawValue: 1 << 3) // Binary1000 -> Dec 8

    // pokemon is able to collide with player & tree & door
    // collisionbitmask of pokemon:   1101  -> 13
    
 //  -> 101  --> tree & player
//  --> 011 -->  collectible & player
    // --> 111 --> tree & collectible & player
  // 1001 --> player & door
    
  static var collisions: [PhysicsBody: [PhysicsBody]] = [
    .player: [.tree],
    .tree: [.player]
  ]
  
  static var contactTests: [PhysicsBody: [PhysicsBody]] = [
    .player: [.collectible, .tree],
    .tree: [.player],
    .collectible: [.player],
  ]
  
  var categoryBitMask: UInt32 {
    return rawValue
  }
  
    
  var collisionBitMask: UInt32 {
    let bitMask = PhysicsBody
      .collisions[self]?
      .reduce(PhysicsBody(), { result, physicsBody in
        return result.union(physicsBody)
      })
    return bitMask?.rawValue ?? 0
  }
  
  var contactTestBitMask: UInt32 {
    let bitMask = PhysicsBody
      .contactTests[self]?
      .reduce(PhysicsBody(), { result, physicsBody in
        return result.union(physicsBody)
      })
    
    return bitMask?.rawValue ?? 0
  }
  
  static func forType(_ type: PhysicsCategory?) -> PhysicsBody? {
    switch type {
    case .player:
      return self.player
    case .tree:
      return self.tree
    case .collectible:
      return self.collectible
    case .door:
      return self.door
    case .none:
      break
    }
    
    return nil
  }
}


class PhysicsComponent: GKComponent {
  
    var bodyCategory: String = "collectible" //PhysicsCategory.tree.rawValue
    var bodyShape: String = "circle" //PhysicsShape.circle.rawValue
  
    override func didAddToEntity() {
        guard let bodyCategory = PhysicsBody.forType(PhysicsCategory(rawValue: bodyCategory)), let sprite = componentNode as? SKSpriteNode
        else {
            return
        }
    
        let size: CGSize = sprite.size
    
        if bodyShape == PhysicsShape.rect.rawValue {
            componentNode.physicsBody = SKPhysicsBody(rectangleOf: size)
        }
        else if bodyShape == PhysicsShape.circle.rawValue {
            componentNode.physicsBody = SKPhysicsBody(circleOfRadius: size.height/2)
        }
    
        componentNode.physicsBody?.categoryBitMask = bodyCategory.categoryBitMask
        componentNode.physicsBody?.collisionBitMask = bodyCategory.collisionBitMask
        componentNode.physicsBody?.contactTestBitMask = bodyCategory.contactTestBitMask
    
        componentNode.physicsBody?.affectedByGravity = false
        componentNode.physicsBody?.allowsRotation = false
    }
  
    override class var supportsSecureCoding: Bool {
        true
    }
}
