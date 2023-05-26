//
//  PokemonEntity.swift
//  PokemonRPG
//
//  Created by Kevin Jusino on 12/1/22.
//

// generating pokemon

import SpriteKit
import GameplayKit

class PokemonEntity: GKEntity {
    
    init(pokemonType: String) {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
