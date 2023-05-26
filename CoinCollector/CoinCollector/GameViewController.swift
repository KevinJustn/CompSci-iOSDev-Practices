//
//  GameViewController.swift
//  CoinCollector
//
//  Created by Kevin Jusino on 11/8/22.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create a new view
        if let view = self.view as! SKView?{
            
            let scene = GameScene(size: CGSize(width: 1336, height: 1024))
            
            // set the scale mode to scale to fill the view window
            scene.scaleMode = .aspectFill
            
            // set the background color
            scene.backgroundColor = UIColor(red: 102/255, green: 157/255, blue: 101/255, alpha: 1)
            
            // present the scene
            view.presentScene(scene)
            
            // set view option
            view.ignoresSiblingOrder = false
            view.showsPhysics = false
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
