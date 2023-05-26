//
//  CollectableB.swift
//  CoinCollector
//
//  Created by Kevin Jusino on 11/21/22.
//

import Foundation
import SpriteKit

enum CollectibleTypeB: String {
    case none
    case bomber
}

class CollectibleB: SKSpriteNode {
    private var collectibleTypeb: CollectibleTypeB = .none
    
    init(collectibleTypeb: CollectibleTypeB){
        var texture: SKTexture!
        self.collectibleTypeb = collectibleTypeb
        
        // set the texture based on the Type
        switch self.collectibleTypeb{
        case .bomber:
            texture = SKTexture(imageNamed: "bomber")
        case .none:
            break
        }
        super.init(texture:texture, color: SKColor.clear, size: texture.size())
        
        // set up the collectibleb
        
        self.name = "co_\(collectibleTypeb)"
        self.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        self.setScale(1.0)
        self.zPosition = Layer.collectibleb.rawValue
        
        // add physics body
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size, center: CGPoint(x: 0.0, y: -self.size.height/2)) // the / might not be needed
        self.physicsBody?.affectedByGravity = false
        
        // set up physics categories for contacts
        self.physicsBody?.categoryBitMask = PhysicsCategory.collectibleb
        self.physicsBody?.contactTestBitMask = PhysicsCategory.player | PhysicsCategory.foreground
        self.physicsBody?.collisionBitMask = PhysicsCategory.none
    }
    
    func drop(dropSpeed: TimeInterval, floorLevel: CGFloat){
        let pos = CGPoint(x: position.x, y: floorLevel)
        let scaleX = SKAction.scaleX(to: 0.5, duration: 1)
        let scaleY = SKAction.scaleY(to: 0.5, duration: 1)
        let scale = SKAction.group([scaleX, scaleY])
        
        let appear = SKAction.fadeAlpha(to: 1, duration: 0.25)
        let moveAction = SKAction.move(to: pos, duration: dropSpeed)
        let actionSequence = SKAction.sequence([appear, scale, moveAction])
        
        self.scale(to: CGSize(width: 0.25, height: 1.0))
        self.run(actionSequence, withKey: "drop")
    }
    
    required init?(coder aDecoder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    func collected() {
        let removeFromParent = SKAction.removeFromParent()
        self.run(removeFromParent)
    }
    
    func missed() {
        let removeFromParent = SKAction.removeFromParent()
        self.run(removeFromParent)
    }
    
    func gameEnd() {
        let removeFromParent = SKAction.removeFromParent()
        self.run(removeFromParent)
    }
}

