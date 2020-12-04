//
//  RotateNote.swift
//  MistakeIt
//
//  Created by IgorMiyamoto on 29/10/20.
//

import SpriteKit

class RotateNode : SKSpriteNode {
    
//    private let playaudio = SKAction.playSoundFileNamed("raio_01", waitForCompletion: false)
    
    private var playaudio : SKAction!
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.isUserInteractionEnabled = true
        playaudio = SKAction.playSoundFileNamed("raio_01", waitForCompletion: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isUserInteractionEnabled = false
        HapticsFeedback.shared.vibrate()
        self.run(playaudio)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.rotate()
        self.isUserInteractionEnabled = true
    }
    
    func rotate() {
        self.run(SKAction.rotate(byAngle: .pi/2, duration: 1))
    }
}

