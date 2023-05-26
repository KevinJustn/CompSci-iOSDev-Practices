//
//  GameScene.swift
//  CoinCollector
//
//  Created by Kevin Jusino on 11/8/22.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    let player = Player()
    var runTask = 0
    
    // labels
    var scoreLevel: SKLabelNode = SKLabelNode()
    var score: Int = 0{
        didSet{
            scoreLevel.text = "Coins: \(score)"
        }
    }
    
    override func didMove(to view: SKView) {
        
        // set up Physics world contact delegate
        physicsWorld.contactDelegate = self
        
        let background = SKSpriteNode(imageNamed: "background")
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.position = CGPoint(x: 0, y: 10)
        background.zPosition = Layer.background.rawValue
        //print(Layer.background.rawValue) // Prints this in the debugger
        addChild(background)
        
        
        let foreground = SKSpriteNode(imageNamed: "foreground")
        foreground.anchorPoint = CGPoint(x: 0, y:0)
        foreground.position = CGPoint(x:15, y: 180)
        foreground.zPosition = Layer.foreground.rawValue // Can I move this node somewhere else?
        
        // add physics body
        foreground.physicsBody = SKPhysicsBody(edgeLoopFrom: foreground.frame)
        foreground.physicsBody?.affectedByGravity = false
        
        foreground.physicsBody?.categoryBitMask = PhysicsCategory.foreground // lets the coins hit the floor
        foreground.physicsBody?.contactTestBitMask = PhysicsCategory.collectible | PhysicsCategory.collectibleb
        foreground.physicsBody?.collisionBitMask = PhysicsCategory.none
        
        print(Layer.foreground.rawValue) // Prints this in the debugger
        addChild(foreground)
        
        
        player.position = CGPoint(x: size.width/2, y: foreground.frame.maxY)
        player.setupConstraints(floor: foreground.frame.maxY)
        player.zPosition = Layer.player.rawValue
        print(Layer.player.rawValue) // Prints this in the debugger
        addChild(player)
        setupLabels()
        spawnItems()
        
    }
    
    func spawnItems() {
        let randomInt = Int.random(in: 0...1)
        if randomInt == 0 {
            spawnCoin()
        }
        else {
            spawnBomber()
        }
    }
    
    func spawnCoin() {
        let collectible = Collectible(collectibleType: CollectibleType.coin)
        
        // set randon position
        let margin = collectible.size.width
        let dropRange = SKRange(lowerLimit: frame.minX + margin, upperLimit: frame.maxX - margin)
        let randomX = CGFloat.random(in: dropRange.lowerLimit...dropRange.upperLimit)
        collectible.position = CGPoint(x:randomX, y:player.position.y * 4)
        //collectible.position = CGPoint(x:player.position.x, y:player.position.y * 2.5) // spawns on player
        addChild(collectible)
        
        collectible.drop(dropSpeed: TimeInterval(2.0), floorLevel: player.frame.minY)
    }
    
    
    func touchDown(atPoint pos: CGPoint) {
        if pos.x < player.position.x {
            player.moveToPosition(pos: pos, direction: "L", speed: 1.0)
        } else {
            player.moveToPosition(pos: pos, direction: "R", speed: 1.0)
        }
    }
    
    func spawnBomber() {
        let collectibleb = CollectibleB(collectibleTypeb: CollectibleTypeB.bomber)
        
        // set randon position
        let margin = collectibleb.size.width
        let dropRange = SKRange(lowerLimit: frame.minX + margin, upperLimit: frame.maxX - margin)
        let randomX = CGFloat.random(in: dropRange.lowerLimit...dropRange.upperLimit)
        collectibleb.position = CGPoint(x:randomX, y:player.position.y * 4)
        //collectible.position = CGPoint(x:player.position.x, y:player.position.y * 2.5) // spawns on player
        addChild(collectibleb)
        
        collectibleb.drop(dropSpeed: TimeInterval(1.5), floorLevel: player.frame.minY)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {self.touchDown(atPoint: t.location(in: self))}
    }
    
    func setupLabels() {
        scoreLevel.name = "score"
        scoreLevel.fontColor = .black
        scoreLevel.fontSize = 45.0
        scoreLevel.horizontalAlignmentMode = .right
        scoreLevel.verticalAlignmentMode = .center
        scoreLevel.zPosition = Layer.ui.rawValue
        scoreLevel.position = CGPoint(x: frame.maxX - 50, y:700)
        scoreLevel.text = "Coins: 0"
        addChild(scoreLevel)
    }
}
    
extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if collision == PhysicsCategory.player | PhysicsCategory.collectible {
            print("player hit collectable")
            score += 1
            
            let body = contact.bodyA.categoryBitMask == PhysicsCategory.collectible ? contact.bodyA.node : contact.bodyB.node
            
            if let sprite = body as? Collectible {
                sprite.collected()
            }
        }
        
        if collision == PhysicsCategory.player | PhysicsCategory.collectibleb {
            print("player hit bomber")
            runTask = 1
            
            let body = contact.bodyA.categoryBitMask == PhysicsCategory.collectibleb ? contact.bodyA.node : contact.bodyB.node
            
            if let sprite = body as? CollectibleB {
                sprite.collected()
            }
        }
        
        if collision == PhysicsCategory.foreground | PhysicsCategory.collectible { // changing this to the above makes it disappear
            print("collectable hit floor")
            
            let body = contact.bodyA.categoryBitMask == PhysicsCategory.collectible ? contact.bodyA.node : contact.bodyB.node
            
            // verify the object is collectable
            
            if let sprite = body as? Collectible {
                sprite.missed()
            }
        }
        
        if collision == PhysicsCategory.foreground | PhysicsCategory.collectibleb {
            print("bomber hit floor")
            
            let body = contact.bodyA.categoryBitMask == PhysicsCategory.collectibleb ? contact.bodyA.node : contact.bodyB.node
            
            // verify the object is collectable
            
            if let sprite = body as? CollectibleB {
                sprite.missed()
            }
        }
        if runTask > 0 {
            print("Game is Over")
            if score == 1 {
                scoreLevel.text = "Game Over! You Collected \(score) Coin!"
            }
            else {
                scoreLevel.text = "Game Over! You Collected \(score) Coins!"
            }
        }
        else {
            spawnItems()
        }
    }
}
