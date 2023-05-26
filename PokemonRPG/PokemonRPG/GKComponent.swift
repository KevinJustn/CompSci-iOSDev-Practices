//
//  GKComponent.swift
//  PokemonRPG
//
//  Created by Kevin Jusino on 12/6/22.
//

import SpriteKit
import GameplayKit


extension GKComponent{
    var componentNode: SKNode {
        if let node = entity?.component(ofType: GKSKNodeComponent.self)?.node{
            return node
        }
        return SKNode()
    }
}
