//
//  Pokedex.swift
//  PokemonRPG
//
//  Created by Kevin Jusino on 12/7/22.
//

import SpriteKit
import GameplayKit
import AVFoundation

class Pokedex: SKScene {
    
    var apiData: APIData = APIData(PokemonID: 0)
    let lb = SKLabelNode(fontNamed: "Chalkduster")
    let lb2 = SKLabelNode(fontNamed: "Chalkduster")
    let lb3 = SKLabelNode(fontNamed: "Chalkduster")

    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    
    var audioPlayer = AVAudioPlayer()
    
    override func sceneDidLoad() {
        let sound = Bundle.main.path(forResource: "town", ofType: "mp3")
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
            audioPlayer.play()
            audioPlayer.numberOfLoops = -1
        }
        catch {
            print(error)
        }
        self.lastUpdateTime = 0
    }
    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
    
    override func didMove(to view: SKView) {
        addChild(lb)
        addChild(lb2)
        addChild(lb3)
        lb3.fontSize = 30
        lb3.fontColor = SKColor.white
        lb3.position = CGPoint(x: 0, y: 270)
        lb3.zPosition = 2
        lb3.text = ("Double tap a Pokemon!")
        childNode(withName: "back")?.isHidden = true
        for i in 1...151 {
            let s = "\(i)"
            childNode(withName: "SKNode_pok")?.childNode(withName: s)?.isHidden = true
        }
        if pC > 0 {
            for j in 1...(iDArrray.count - 1) {
                let k = iDArrray[j]
                let l = "\(k)"
                childNode(withName: "SKNode_pok")?.childNode(withName: l)?.isHidden = false
            }
        }
    }
    
    func loadGame() {
        let scene = SKScene(fileNamed: "GameScene")
        scene?.scaleMode = .aspectFill
        sleep(1)
        
        self.view?.presentScene(scene)
    }
    
    func touchDown(atPoint pos : CGPoint) {
        lb3.removeFromParent()
        print("touch down")
        
        lb.fontSize = 45
        lb.fontColor = SKColor.red
        lb.position = CGPoint(x: 0, y: 270)
        lb.zPosition = 2
        lb2.fontSize = 45
        lb2.fontColor = SKColor.red
        lb2.position = CGPoint(x: 0, y: 220)
        lb2.zPosition = 2
        
        let nodeAtPoint = atPoint(pos)
        if let touchedNode = nodeAtPoint as? SKSpriteNode{
            for a in 1...151 {
                if touchedNode.name == "\(a)" {
                    apiData.fetchNew(PokemonID: a)
                    let pok = apiData.pokemonName
                    let pokID = apiData.id
                    lb.text = "Name: \(pok)"
                    lb2.text = "ID: \(pokID)"
                }
            }
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
    
    // generate pokemon
    func spawnPokemonEntity() { // to spawn different pokemon edit here
        let pokemonEntity = PokemonEntity(pokemonType: "pokemon")
        let randInt = Int.random(in: 1...151)
        let st = "\(randInt)"
        let renderComponent = RenderComponent(imageNamed: st, scale: 2)
        
        pokemonEntity.addComponent(renderComponent)
        
        let dropRange = SKRange(lowerLimit: -200, upperLimit: 200)
        let randomX = CGFloat.random(in: dropRange.lowerLimit...dropRange.upperLimit)
        let randomY = CGFloat.random(in: dropRange.lowerLimit...dropRange.upperLimit)
        
        if (pokemonEntity.component(ofType: RenderComponent.self)?.spriteNode) != nil {
            
            childNode(withName: "SKNode_p")?.childNode(withName: st)?.isHidden = false
            childNode(withName: "SKNode_p")?.childNode(withName: st)?.position = CGPoint(x: randomX, y: randomY)
            childNode(withName: "SKNode_p")?.childNode(withName: st)?.run(SKAction.moveBy(x: randomX, y: randomY, duration: 1.0))
            print(st)

        }
    }
}

