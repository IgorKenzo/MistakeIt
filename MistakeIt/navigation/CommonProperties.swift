//
//  CommonProperties.swift
//  MistakeIt
//
//  Created by IgorMiyamoto on 13/11/20.
//

import Foundation
import SpriteKit

//Protocol to common properties between SKScenes
protocol CommonProperties where Self : SKScene {
    var levelName : LevelState! { get set }
    var settingsButton: GameButtonNode! { get set }
    var hintButton: GameButtonNode! { get set }
    var background : SKEffectNode! { get set }
    var levelLabel : SKLabelNode! { get set }
    
    func setButtons(retry: @escaping () -> Void)
    func addButtons()
    func removeButtons()
    func setBackground(bgImg : SKSpriteNode)
    func setLevelName(name : LevelState)
    func blurBackground()
    func addLevelLabel()
    func endLevel(fowardDestination: @escaping () -> Void)
    func endLevel(backgroundImage: SKTexture, fowardDestination: @escaping () -> Void)
}

//Default Implementation
extension CommonProperties {
    
    //Instanciate Hint and Settings Buttons
    func setButtons(retry: @escaping () -> Void) {
        settingsButton = GameButtonNode(image: SKTexture(imageNamed: "settings"), onTap: {})
        settingsButton.position = CGPoint(x: 270, y: -710)
        settingsButton.setScale(0.03)
        settingsButton.zPosition = 3
        
        //MARK: Hint and Settings buttons
        hintButton = GameButtonNode(image: SKTexture(imageNamed: "hint"), onTap: {})
        hintButton.position = CGPoint(x: -270, y: -710)
        hintButton.setScale(0.03)
        hintButton.zPosition = 3
        
        let hintLabel = SKLabelNode(fontNamed: "Abyss")
        hintLabel.text = hints[self.levelName]
        hintLabel.zPosition = 2
        hintLabel.fontColor = .black
        
        let hintPopUp = SKSpriteNode(imageNamed: "hint-bubble")
        hintPopUp.size = CGSize(width: hintPopUp.size.width * 2, height: hintPopUp.size.height * 2)
        hintPopUp.position = CGPoint(x: hintButton.position.x + hintPopUp.size.width/2, y: hintButton.position.y + hintPopUp.size.height/2)
        
        hintLabel.preferredMaxLayoutWidth = hintPopUp.frame.width - 20
        hintLabel.numberOfLines = 0
        hintPopUp.addChild(hintLabel)
        hintLabel.position = CGPoint.zero
        
        let btnRetry = GameButtonNode(image: SKTexture(imageNamed: "retry"), onTap: {
            HapticsFeedback.shared.vibrate()
            retry()
        })
        let btnHome = GameButtonNode(image: SKTexture(imageNamed: "home"), onTap: {
            HapticsFeedback.shared.vibrate()
            PlayViewController.BackToMenu()
        })//
   //     let btnMusic = GameButtonNode(image: SKTexture(imageNamed: "music"), onTap: {})

        let settingsButtons = [btnRetry, btnHome]   //, btnMusic]
        btnHome.setScale(0.03)
        btnRetry.setScale(0.03)
  //      btnMusic.setScale(0.02)
        
        //MARK: Buttons Animations
        var animationsFw : [SKAction] = []
        let animationBack : SKAction = SKAction.move(to: settingsButton.position, duration: 0.3)

        for i in 0 ..< settingsButtons.count {
            settingsButtons[i].position = settingsButton.position
            settingsButtons[i].zPosition = 3
            animationsFw.append(SKAction.move(to: CGPoint(x: settingsButton.position.x, y: settingsButton.position.y + (CGFloat(i + 1) * (settingsButtons[i].size.height + 60))), duration: 0.3))
        }
        
        //MARK: Buttons actions
        
        hintButton.onTap = { [self] in
            HapticsFeedback.shared.vibrate()
            if !hintButton.pressed {
                self.blurBackground()
                self.addChild(hintPopUp)
                settingsButton.zPosition = -2
            }
            else {
                self.blurBackground()
                hintPopUp.removeFromParent()
                settingsButton.zPosition = 3
            }
        }
        
        settingsButton.onTap = { [self] in
            HapticsFeedback.shared.vibrate()
            if !settingsButton.pressed {
                self.blurBackground()
                settingsButton.run(SKAction.rotate(byAngle: -.pi/2, duration: 0.3))
                settingsButton.isUserInteractionEnabled = false
                for i in 0..<settingsButtons.count {
                    self.addChild(settingsButtons[i])
                    settingsButtons[i].run(animationsFw[i])
                }
                
                hintButton.zPosition = -3
                Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false){_ in
                    self.settingsButton.isUserInteractionEnabled = true
                }
                
            }
            else{
                self.blurBackground()
                settingsButton.run(SKAction.rotate(byAngle: .pi/2, duration: 0.3))
                settingsButton.isUserInteractionEnabled = false
                for i in 0..<settingsButtons.count {
                    settingsButtons[i].run(animationBack,completion: {
                        settingsButtons[i].removeFromParent()
                    })
                }
                hintButton.zPosition = 3
                Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false){_ in
                    self.settingsButton.isUserInteractionEnabled = true
                }
            }
            
        }
    }
    
    //Add Hint and Settins Buttons to scene
    func addButtons(){
        self.addChild(settingsButton)
        self.addChild(hintButton)
    }
    
    //Remove Hint and Settins Buttons from scene
    func removeButtons(){
        self.hintButton.removeFromParent()
        self.settingsButton.removeFromParent()
    }
    
    //Blurs and "un"blur the background
    func blurBackground() {
        self.background.shouldEnableEffects = !self.background.shouldEnableEffects
    }
    
    //Set the background image and add it to the scene
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
    
    //Set the level name, set this first
    func setLevelName(name: LevelState) {
        self.levelName = name
    }
    
    //Add the label to the scene
    func addLevelLabel(){
        levelLabel = SKLabelNode(fontNamed: "Abyss")
        levelLabel.text =  leveltexts[levelName]
        levelLabel.fontSize = 40
        levelLabel.preferredMaxLayoutWidth = self.size.width - 200
        levelLabel.numberOfLines = 0
        levelLabel.verticalAlignmentMode = .center
        levelLabel.horizontalAlignmentMode = .center
        levelLabel.position = CGPoint(x: 0, y: self.frame.height/2 - 120)
        levelLabel.zPosition = 3
        self.addChild(levelLabel)
    }
    
    func removeLevelLabel(){
        self.levelLabel.removeFromParent()
    }
    
    func endLevel(fowardDestination: @escaping () -> Void) {
        //remove hint and settings buttons
        //from protocol
        self.removeButtons()
        self.removeLevelLabel()

        audios["fim-nivel"]?.play()
        
        //end buttons
        levelLabel.removeFromParent()

        let home = GameButtonNode(image: SKTexture(imageNamed: "home"), onTap: {
            HapticsFeedback.shared.vibrate()
            PlayViewController.BackToMenu()
        })
        let foward = GameButtonNode(image: SKTexture(imageNamed: "foward"), onTap: {
            HapticsFeedback.shared.vibrate()
            fowardDestination()
            
        })
        
        home.position = CGPoint(x: -50 , y: -self.frame.height/2)
        foward.position = CGPoint(x: 50 , y: -self.frame.height/2)

        home.setScale(0.02)
        foward.setScale(0.02)
        
        home.zPosition = 3
        foward.zPosition = 3

        self.addChild(home)
        self.addChild(foward)

        home.run(SKAction.move(to: CGPoint(x: -50 , y: -self.frame.height/2 + 150), duration: 0.7))
        foward.run(SKAction.move(to: CGPoint(x: 50 , y: -self.frame.height/2 + 150), duration: 0.7))
        
        UserDefaultManager.shared.storeLastLevelPlayed(level: self.levelName)
        UserDefaultManager.shared.unlockLevel(currentLevel: self.levelName)
    }
    
    func endLevel(backgroundImage: SKTexture, fowardDestination: @escaping () -> Void) {
        //remove hint and settings buttons
        //from protocol
        self.removeButtons()
        self.removeLevelLabel()

        audios["fim-nivel"]?.play()

        //end background and buttons

        let bg = background.childNode(withName: "LevelBackground") as! SKSpriteNode
        bg.texture = backgroundImage
        levelLabel.removeFromParent()

        let home = GameButtonNode(image: SKTexture(imageNamed: "home"), onTap: PlayViewController.BackToMenu)
        let foward = GameButtonNode(image: SKTexture(imageNamed: "foward"), onTap: {fowardDestination()})

        home.position = CGPoint(x: -50 , y: -self.frame.height/2)
        foward.position = CGPoint(x: 50 , y: -self.frame.height/2)

        home.setScale(0.02)
        foward.setScale(0.02)
        
        home.zPosition = 3
        foward.zPosition = 3

        self.addChild(home)
        self.addChild(foward)

        home.run(SKAction.move(to: CGPoint(x: -50 , y: -self.frame.height/2 + 150), duration: 0.7))
        foward.run(SKAction.move(to: CGPoint(x: 50 , y: -self.frame.height/2 + 150), duration: 0.7))
        
        UserDefaultManager.shared.storeLastLevelPlayed(level: self.levelName)
        UserDefaultManager.shared.unlockLevel(currentLevel: self.levelName)
    }
}
