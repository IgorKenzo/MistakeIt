//
//  DefaultButtons.swift
//  MistakeIt
//
//  Created by IgorMiyamoto on 16/11/20.
//

import Foundation
import SpriteKit

protocol DefaultButtons where Self : SKScene {
    var settingsButton: GameButtonNode! { get set }
    var hintButton: GameButtonNode! { get set }
    func setButtons()
    func addButtons()
    func removeButtons()
}

extension DefaultButtons {
    
    
    func setButtons() {
        settingsButton = GameButtonNode(image: SKTexture(imageNamed: "settings"), onTap: {})
        settingsButton.position = CGPoint(x: 270, y: -510)
        
        settingsButton.zPosition = 1
        
        //MARK: Hint and Settings buttons
        hintButton = GameButtonNode(image: SKTexture(imageNamed: "hint"), onTap: {})
        hintButton.position = CGPoint(x: -270, y: -510)
        
        hintButton.zPosition = 1
        
        //hintPopUp.size = CGSize(width: hintPopUp.size.width * 2, height: hintPopUp.size.height * 2)
        //hintPopUp.position = CGPoint(x: hintButton.position.x + hintPopUp.size.width/2, y: hintButton.position.y + hintPopUp.size.height/2)
        //hintPopUp.addChild(hintLabel)
        
        
        let btnRetry = GameButtonNode(image: SKTexture(imageNamed: "retry"), onTap: {})
        let btnHome = GameButtonNode(image: SKTexture(imageNamed: "home"), onTap: {})
        let btnMusic = GameButtonNode(image: SKTexture(imageNamed: "music"), onTap: {})

        let settingsButtons = [btnRetry, btnHome, btnMusic]

        
        //MARK: Buttons Animations
        var animationsFw : [SKAction] = []
        let animationBack : SKAction = SKAction.move(to: settingsButton.position, duration: 0.3)

        for i in 0 ..< settingsButtons.count {
            settingsButtons[i].position = settingsButton.position
            settingsButtons[i].zPosition = 1
            animationsFw.append(SKAction.move(to: CGPoint(x: settingsButton.position.x, y: settingsButton.position.y + (CGFloat(i + 1) * (settingsButtons[i].size.height + 30))), duration: 0.3))
        }
        
        //MARK: Buttons actions
        
        hintButton.onTap = { [self] in
            if !hintButton.pressed {
                //self.blurBackground()
                //self.addChild(hintPopUp)
                settingsButton.zPosition = -2
            }
            else {
                //self.blurBackground()
                //hintPopUp.removeFromParent()
                settingsButton.zPosition = 1
            }
        }
        
        settingsButton.onTap = { [self] in
            
            if !settingsButton.pressed {
                //self.blurBackground()
                settingsButton.run(SKAction.rotate(byAngle: -.pi/2, duration: 0.3))
                
                for i in 0..<settingsButtons.count {
                    self.addChild(settingsButtons[i])
                    settingsButtons[i].run(animationsFw[i])
                }
                
                hintButton.zPosition = -3
            }
            else{
                //self.blurBackground()
                settingsButton.run(SKAction.rotate(byAngle: .pi/2, duration: 0.3))
                
                for i in 0..<settingsButtons.count {
                    settingsButtons[i].run(animationBack,completion: {
                        settingsButtons[i].removeFromParent()
                    })
                }
                hintButton.zPosition = 1
            }
            
        }
    }
    
    func addButtons(){
        self.addChild(settingsButton)
        self.addChild(hintButton)
    }
    
    func removeButtons(){
        self.hintButton.removeFromParent()
        self.settingsButton.removeFromParent()
    }
}

