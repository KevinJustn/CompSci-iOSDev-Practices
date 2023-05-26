//
//  Player.swift
//  CoinCollector
//
//  Created by Kevin Jusino on 11/8/22.
//

import Foundation
import SpriteKit

class Player:SKSpriteNode {
    // MARK: - PROPERTIES
    
    // MARK: - INIT
    init(){
        // set default texture
        let texture = SKTexture(imageNamed: "pixkirb")
        
        // call super.init()
        super.init(texture: texture, color: .clear, size: texture.size())
        
        self.name = "player"
        self.setScale(0.40) // increases size and hitbox
        self.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        self.zPosition = Layer.player.rawValue
        
        // add physics body
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size, center: CGPoint(x: 0.0, y: self.size.height/2)) // ****************
        self.physicsBody?.affectedByGravity = false
        
        // set up physics categories for contacts
        self.physicsBody?.categoryBitMask = PhysicsCategory.player
        self.physicsBody?.contactTestBitMask = PhysicsCategory.collectible | PhysicsCategory.collectibleb
        self.physicsBody?.collisionBitMask = PhysicsCategory.none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints(floor: CGFloat){
        let range = SKRange(lowerLimit:floor, upperLimit: floor)
        let locktoPlatform = SKConstraint.positionY(range)
        constraints = [locktoPlatform]
    }
    
    func moveToPosition(pos: CGPoint, direction: String, speed: TimeInterval) {
        switch direction {
        case "L":
            xScale = -abs(xScale)
        default:
            xScale = abs(xScale)
        }
        let moveAction = SKAction.move(to: pos, duration: speed)
        run(moveAction)
    }
}
