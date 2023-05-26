//
//  HPComponent.swift
//  PokemonRPG
//
//  Created by Kevin Jusino on 12/6/22.
//

import SpriteKit
import GameplayKit

class HPComponent: GKComponent{
    @GKInspectable var currentHealth: Int = 3
    @GKInspectable var maxHealth: Int = 3
    
    private let healthFull = SKTexture(imageNamed: "health_full")
    private let healthEmpty = SKTexture(imageNamed: "health_empty")
    
    
    override func didAddToEntity() {
        guard let node = entity?.component(ofType: GKSKNodeComponent.self)?.node
        else{
            return
        }
        if let HPMeter = SKReferenceNode(fileNamed: "HealthMeter"){
            HPMeter.position = CGPoint(x:0, y:50)
            node.addChild(HPMeter)
            updateHealth(3, forNode: node)
        }
    }

    func updateHealth(_ value: Int, forNode node: SKNode?){
        currentHealth += value
        if currentHealth > maxHealth{
            currentHealth = maxHealth
        }
        for barNum in 1...maxHealth{
            setupBar(at: barNum)
        }
    }
    
    func setupBar(at num: Int){
        guard let node = entity?.component(ofType: GKSKNodeComponent.self)?.node
        else{
            return
        }
        if let health = node.childNode(withName: ".//health_\(num)")
            as? SKSpriteNode{
            if currentHealth >= num{
                health.texture = healthFull
            }
            else{
                health.texture = healthEmpty
                health.colorBlendFactor = 0.0
            }
        }
    }
    
    override func willRemoveFromEntity() {
        
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        // update entities
    }
    
    override class var supportsSecureCoding: Bool{
        true
    }
}



