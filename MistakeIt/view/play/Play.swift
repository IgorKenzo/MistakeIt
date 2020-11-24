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
        
    
//    func numberOfLines(lb : SKLabelNode) -> Int {
//        let preferredMaxWidth: CGFloat = 500
//
//        let label = UILabel()
//        label.text = lb.text
//        label.font = UIFont(name: lb.fontName!, size: lb.fontSize)
//        label.numberOfLines = lb.numberOfLines
//
//        label.frame.size.width = preferredMaxWidth
//        label.sizeToFit()
//        label.frame.size.width = preferredMaxWidth
//
//        return Int(label.frame.size.height / label.font.pointSize)
//    }
}
