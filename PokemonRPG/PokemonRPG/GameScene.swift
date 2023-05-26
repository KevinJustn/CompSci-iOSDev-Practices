//
//  GameScene.swift
//  PokemonRPG
//
//  Created by Kevin Jusino on 12/6/22.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene {
    
    var randIntArr = Array(1...151)
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    var sceneCamera : SKCameraNode = SKCameraNode() // getting camera to follow
    var controller : SKNode = SKNode() // getting controller to follow
    
    private var lastUpdateTime : TimeInterval = 0
    private var player: Player?
    
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
        camera = sceneCamera // getting camera to follow
        controller = childNode(withName: "SKNode_C") ?? SKNode() // getting controller to follow
        
        
        player = childNode(withName: "player") as? Player
        //player?.move(.stop)
        physicsWorld.contactDelegate = self
        for i in 1...151 {
            let s = "\(i)"
            //childNode(withName: s)?.isHidden = true
            childNode(withName: "SKNode_p")?.childNode(withName: s)?.isHidden = true
        }
        for i in 1...151 {
            spawnPokemonEntity(i)
        }
    }
    
    func loadPokedex() {
        let scene = SKScene(fileNamed: "Pokedex")
        scene?.scaleMode = .aspectFill
        
        var apiData: APIData = APIData(PokemonID: Int(iD) ?? 0)
        apiData.fetchNew(PokemonID: Int(iD) ?? 0)
        sleep(1)
        
        print(apiData.pokemonName)
        print(apiData.base_exp)
        print(apiData.capture_rate)
        
        let name = apiData.pokemonName
        let labelRecent = SKLabelNode(fontNamed: "Chalkduster")
        labelRecent.text = "Recently Caught:"
        labelRecent.fontSize = 45
        labelRecent.fontColor = SKColor.red
        labelRecent.position = CGPoint(x: 0, y: 170)
        labelRecent.zPosition = 2
        
        let recentPokemon = SKLabelNode(fontNamed: "Chalkduster")
        recentPokemon.text = (apiData.pokemonName)
        if iD == "" {
            recentPokemon.text = "No Pokemon Caught!"
        }
        recentPokemon.fontSize = 40
        recentPokemon.fontColor = SKColor.red
        recentPokemon.position = CGPoint (x:0, y: 120)
        recentPokemon.zPosition = 2
        
        let totalCaught = SKLabelNode(fontNamed: "Chalkduster")
        totalCaught.text = "Pokemon Caught: \(pC)/151"
        totalCaught.fontSize = 35
        totalCaught.fontColor = SKColor.red
        totalCaught.position = CGPoint (x:0, y: 70)
        totalCaught.zPosition = 2
        
        scene?.addChild(labelRecent)
        scene?.addChild(recentPokemon)
        scene?.addChild(totalCaught)
    
        self.view?.presentScene(scene)
    }
    
    func touchDown(atPoint pos : CGPoint) {
        print("touch down")
        let nodeAtPoint = atPoint(pos)
        if let touchedNode = nodeAtPoint as? SKSpriteNode{
            if touchedNode.name?.starts(with: "controller_") == true{
                let direction = touchedNode.name?.replacingOccurrences(of: "controller_", with: "")
                player?.move(Direction(rawValue: direction ?? "stop")!)
            }
            else if touchedNode.name?.starts(with: "pkdx") == true { // for pokedex
                print("Menu activated")
                loadPokedex()
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
        // Called before each frame is rendered
        camera?.position.x = player?.position.x ?? 0 // getting camera to follow
        camera?.position.y = player?.position.y ?? 0 // getting camera to follow
        controller.position.x = player?.position.x ?? 0// getting controller to follow
        controller.position.y = player?.position.y ?? 0 // getting controller to follow
        
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
    func spawnPokemonEntity(_ i: Int) { // to spawn different pokemon edit here
        let pokemonEntity = PokemonEntity(pokemonType: "pokemon")
        let st = "\(i)"
        let renderComponent = RenderComponent(imageNamed: st, scale: 2)
        
        pokemonEntity.addComponent(renderComponent)
        
        let dropRangeX = SKRange(lowerLimit: -255, upperLimit: 255)
        let dropRangeY = SKRange(lowerLimit: -190, upperLimit: 190)
        let randomX = CGFloat.random(in: dropRangeX.lowerLimit...dropRangeX.upperLimit)
        let randomY = CGFloat.random(in: dropRangeY.lowerLimit...dropRangeY.upperLimit)
        
        if (pokemonEntity.component(ofType: RenderComponent.self)?.spriteNode) != nil {
            
            childNode(withName: "SKNode_p")?.childNode(withName: st)?.isHidden = false
            childNode(withName: "SKNode_p")?.childNode(withName: st)?.zPosition = 4
            childNode(withName: "SKNode_p")?.childNode(withName: st)?.position = CGPoint(x: randomX, y: randomY)
            childNode(withName: "SKNode_p")?.childNode(withName: st)?.run(SKAction.moveBy(x: randomX, y: randomY, duration: 1.0))
            
        }
    }
}

