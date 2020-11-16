//
//  Scene2ViewController.swift
//  MistakeIt
//
//  Created by marcelo frost marchesan on 06/11/20.
//

import UIKit
import SpriteKit
import GameplayKit

class Scene2ViewController: UIViewController {

    override func viewDidLoad(){
        super.viewDidLoad()
    
        if let view = self.view as! SKView? {
             //Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "Scene2") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill

                // Present the scene
                view.presentScene(scene)
            }

        }
    }

}
