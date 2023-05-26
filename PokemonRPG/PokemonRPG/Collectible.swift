//
//  Collectible.swift
//  PokemonRPG
//
//  Created by Kevin Jusino on 12/6/22.
//

import SpriteKit
import GameplayKit

public var pC = 0
public var iD = ""
public var iDArrray = [0]

struct Collectible{
    let type: GameObjectTypes
    let collectSoundFile: String
    
    init(type: GameObjectTypes, collectSoundFile: String) {
        self.type = type
        self.collectSoundFile = collectSoundFile
    }
}

class CollectibleComponent: GKComponent{
    var collectibleType: String = "pokemon" //GameObject.defaultCollectibleType
    var value: Int = 1 // 1
    private var collectSoundAction = SKAction()

    override func didAddToEntity() {
        guard let collectible =
          GameObject.forCollectibleType(GameObjectTypes(rawValue: collectibleType))
          else {
            return
        }
        
        collectSoundAction =
          SKAction.playSoundFileNamed(collectible.collectSoundFile,
                                      waitForCompletion: false)
    }
    
    func collectedItem() {
      componentNode.run(collectSoundAction, completion: {
        self.componentNode.removeFromParent()
          pC += 1
          print("Caught: \(pC)")
          iD = "\(self.componentNode.name)"
          iD = iD.replacingOccurrences(of: "Optional(\"", with: "")
          iD = iD.replacingOccurrences(of: "\")", with: "")
          //print("ID: \(iD)")
          iDArrray.append(Int(iD)!)
          //print(iDArrray)
      })
    }

    override class var supportsSecureCoding: Bool{
        true
    }
}
