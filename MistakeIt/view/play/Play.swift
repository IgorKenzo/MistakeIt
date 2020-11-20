//
//  Play.swift
//  MistakeIt
//
//  Created by IgorMiyamoto on 19/11/20.
//

import SpriteKit

class Play: SKScene, SceneManager {
    var LevelName : LevelState?
    var backToMenu : (()->Void)?
    
    override func didMove(to view: SKView) {
        self.loadScene(withIdentifier: LevelName!)
    }
}
