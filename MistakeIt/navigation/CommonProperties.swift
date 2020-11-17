//
//  CommonProperties.swift
//  MistakeIt
//
//  Created by IgorMiyamoto on 13/11/20.
//

import Foundation
import SpriteKit

protocol CommonProperties where Self : SKScene {
    var levelName : LevelState! { get set }
    var settingsButton: GameButtonNode! { get set }
    var hintButton: GameButtonNode! { get set }
    var background : SKEffectNode! { get set }
    var levelLabel : SKLabelNode! { get set }
    
    func setButtons()
    func addButtons()
    func removeButtons()
    func setBackground(bgImg : SKSpriteNode)
    func setLevelName(name : LevelState)
    func blurBackground()
    func addLevelLabel()
}

extension CommonProperties {
    
    func setButtons() {
        settingsButton = GameButtonNode(image: SKTexture(imageNamed: "settings"), onTap: {})
        settingsButton.position = CGPoint(x: 270, y: -510)
        
        settingsButton.zPosition = 1
        
        //MARK: Hint and Settings buttons
        hintButton = GameButtonNode(image: SKTexture(imageNamed: "hint"), onTap: {})
        hintButton.position = CGPoint(x: -270, y: -510)
        
        hintButton.zPosition = 1
        
        let hintLabel = SKLabelNode(text: hints[self.levelName])
        hintLabel.zPosition = 2
        hintLabel.fontColor = .black
        
        let hintPopUp = SKSpriteNode(imageNamed: "hint-bubble")
        hintPopUp.size = CGSize(width: hintPopUp.size.width * 2, height: hintPopUp.size.height * 2)
        hintPopUp.position = CGPoint(x: hintButton.position.x + hintPopUp.size.width/2, y: hintButton.position.y + hintPopUp.size.height/2)
        hintPopUp.addChild(hintLabel)
        
        
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
                self.blurBackground()
                self.addChild(hintPopUp)
                settingsButton.zPosition = -2
            }
            else {
                self.blurBackground()
                hintPopUp.removeFromParent()
                settingsButton.zPosition = 1
            }
        }
        
        settingsButton.onTap = { [self] in
            
            if !settingsButton.pressed {
                self.blurBackground()
                settingsButton.run(SKAction.rotate(byAngle: -.pi/2, duration: 0.3))
                
                for i in 0..<settingsButtons.count {
                    self.addChild(settingsButtons[i])
                    settingsButtons[i].run(animationsFw[i])
                }
                
                hintButton.zPosition = -3
            }
            else{
                self.blurBackground()
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
    
    func blurBackground() {
        self.background.shouldEnableEffects = !self.background.shouldEnableEffects
    }
    
    func setBackground(bgImg : SKSpriteNode) {
        bgImg.name = "LevelBackground"
        let filter = CIFilter(name: "CIGaussianBlur", parameters: ["inputRadius" : NSNumber(value:200.0)])
        background = SKEffectNode()
        background.filter = filter
        background.shouldRasterize = true
        background.shouldEnableEffects = false
        background.addChild(bgImg)
        background.zPosition = 0
        self.addChild(background)
    }
    
    func setLevelName(name: LevelState) {
        self.levelName = name
    }
    
    func addLevelLabel(){
        levelLabel = SKLabelNode(text: leveltexts[levelName])
        levelLabel.fontSize = 40
        levelLabel.position = CGPoint(x: 0, y: self.frame.height/2 - 120)
        self.addChild(levelLabel)
    }
}
