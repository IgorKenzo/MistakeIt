//
//  GameViewController.swift
//  ProjetoErro
//
//  Created by IgorMiyamoto on 14/10/20.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {



    override func viewDidLoad(){
        super.viewDidLoad()
    
        if let view = self.view as! SKView? {
             //Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill

                // Present the scene
                view.presentScene(scene)
            }

        }
    }

}
