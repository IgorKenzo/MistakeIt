//
//  PlayViewController.swift
//  MistakeIt
//
//  Created by IgorMiyamoto on 19/11/20.
//

import Foundation
import SpriteKit
import AVFoundation

class PlayViewController: UIViewController {
    var LevelName : LevelState?
    static var BackToMenu = {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "PlayScene") as? Play{
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                scene.LevelName = LevelName
                scene.backToMenu = {}
                // Present the scene
                view.presentScene(scene)
            }
            PlayViewController.BackToMenu = {
                self.performSegue(withIdentifier: "unwindToMenu", sender: nil)
                audios["background"]!.play()
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
