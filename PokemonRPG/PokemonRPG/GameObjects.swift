//
//  GameObjects.swift
//  PokemonRPG
//
//  Created by Kevin Jusino on 12/6/22.
//

import SpriteKit
import GameplayKit


enum GameObjectTypes: String{
    case pokemon
}


struct GameObject{
    static let pokemon = Pokemon()
    static let defaultCollectibleType = GameObjectTypes.pokemon.rawValue

    struct Pokemon {
      let collectibleSettings = Collectible(type: .pokemon,
                                            collectSoundFile: "get_pokemon")
    }

  static func forCollectibleType(_ type: GameObjectTypes?) -> Collectible? {
    switch type {
    case .pokemon:
        return GameObject.pokemon.collectibleSettings
    default:
      return nil
    }
  }
}
