//
//  SceneManager.swift
//  MistakeIt
//
//  Created by IgorMiyamoto on 19/11/20.
//

import SpriteKit

protocol SceneManager {
    func loadScene(withIdentifier identifier: LevelState)
    
}

private let sceneSize = CGSize(width: 828, height: 1792)

extension SceneManager where Self: SKScene {

     // No xCode level editor
    func loadScene(withIdentifier identifier: LevelState) {

        let scene: SKScene

        switch identifier {
            case .lamp:
                scene = FaseLampada(size: sceneSize)
            case .peni:
                scene = FasePenicilina(size: sceneSize)
            default:
                scene = SKScene(size: sceneSize)
        }

        let transition = SKTransition()
        scene.scaleMode = .aspectFill
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        view?.presentScene(scene, transition: transition)
    }

      // With xCode level editor
//     func loadScene(withIdentifier identifier: SceneIdentifier) {
//
//           guard let scene = SKScene(fileNamed: identifier.rawValue) else { return }
//           scene.scaleMode = .aspectFill
//           let transition = SKTransition...
//           view?.presentScene(scene, transition: transition)
//     }
}
