//
//  PhysicsContact.swift
//  PokemonRPG
//
//  Created by Kevin Jusino on 12/6/22.
//

import SpriteKit

extension GameScene: SKPhysicsContactDelegate {
  func didBegin(_ contact: SKPhysicsContact) {

      
      //contact.bodyA.categoryBitMask = 1 --> binary 001
      //contact.bodyB.categoryBitMask = 4 --> binary 100
      //collision = 101  -> 5
    let collision = contact.bodyA.categoryBitMask
      | contact.bodyB.categoryBitMask
    
    switch collision {
        
    case PhysicsBody.player.categoryBitMask | PhysicsBody.collectible.categoryBitMask:
      let playerNode = contact.bodyA.categoryBitMask == PhysicsBody.player.categoryBitMask ? contact.bodyA.node : contact.bodyB.node
      
      let collectibleNode = contact.bodyA.categoryBitMask == PhysicsBody.collectible.categoryBitMask ? contact.bodyA.node : contact.bodyB.node
      
      if let player = playerNode as? Player, let collectible = collectibleNode {
          print("Collect!")
          player.collectItem(collectible)
      }

    default:
      break
    }
  }
}
