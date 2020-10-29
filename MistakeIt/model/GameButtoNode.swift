//
//  GameButton.swift
//  MistakeIt
//
//  Created by IgorMiyamoto on 27/10/20.
//

import SpriteKit

class GameButtonNode : SKSpriteNode {
    
    var pressed = false
    var onTap : () -> Void
        
//    required init?(coder aDecoder: NSCoder) {
//
//        /* Call parent initializer e.g. SKSpriteNode */
//        super.init(coder: aDecoder)
//
//        /* Enable touch on button node */
//        self.isUserInteractionEnabled = true
//    }
    
    init(image : SKTexture, onTap: @escaping () -> Void) {
        self.onTap = onTap
        
        super.init(texture: image, color: UIColor.clear, size: image.size())
        
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isUserInteractionEnabled = false
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.onTap()
        pressed = !pressed
        self.isUserInteractionEnabled = true
    }
}
