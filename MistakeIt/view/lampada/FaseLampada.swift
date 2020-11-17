//
//  FaseLampada.swift
//  MistakeIt
//
//  Created by IgorMiyamoto on 27/10/20.
//

import SpriteKit

class FaseLampada: SKScene, CommonProperties {
    
    
    var levelName: LevelState!
    
    var settingsButton: GameButtonNode!
    
    var hintButton: GameButtonNode!
    
    var background: SKEffectNode!
    
    var levelLabel: SKLabelNode!
    
    var filament1 : RotateNode!
    var filament2 : RotateNode!
    var playing = true
    
    override func didMove(to view: SKView) {
        setLevelName(name: .lamp)
        setBackground(bgImg: SKSpriteNode(imageNamed: "blur"))
        setButtons()
        addButtons()
        addLevelLabel()
        
        //MARK: Load Sprites and positions
        setfilaments()
        setLighting()
    }
    
    func setfilaments() {
        filament1 = RotateNode(imageNamed: "fila1")
        filament2 = RotateNode(imageNamed: "fila2")
        
        filament1.position = CGPoint(x: -89, y: -80)
        filament2.position = CGPoint(x: 67, y: -80)
        
        filament1.zRotation = .pi/2
        
        filament1.zPosition = 1
        filament2.zPosition = 1
        
        background.addChild(filament1)
        background.addChild(filament2)
        
        filament2.rotate()
        filament2.rotate()
    }
    
    //function to transform radians to degrees, returns an int value
    func rad2deg(_ rad: CGFloat) -> Int {
        return Int(rad * 180 / 3.14)
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        //Check if still playing ( didn`t align filaments)
        if playing {
            
            //Conditions to position the lightining when filament is aligned
            if (rad2deg(filament1.zRotation) % 360 == 0) {
                for node in filament1.children {
                    node.isHidden = false
                }
            }
            else{
                for node in filament1.children {
                    node.isHidden = true
                }
            }

            if (rad2deg(filament2.zRotation) % 360 == 0) {
                for node in filament2.children {
                    node.isHidden = false
                }
            }
            else{
                for node in filament2.children {
                    node.isHidden = true
                }
            }
            
            //Compare filaments rotation
            if (rad2deg(filament1.zRotation) % 360 == 0) && (rad2deg(filament2.zRotation) % 360 == 0) {
                playing = false
                endLevel()
            }

        }
    }
    
    
    func setLighting(){
        
        let lightining = SKSpriteNode(imageNamed: "lighting")
        filament1.addChild(lightining)
        lightining.position = CGPoint(x: -40, y: 90)
        lightining.isHidden = true
        
        let lightining2 = SKSpriteNode(imageNamed: "lighting")
        filament2.addChild(lightining2)
        lightining2.position = CGPoint(x: 0, y: 90)
        lightining2.isHidden = true
    }
    
    func endLevel() {
        //remove hint and settings buttons
        removeButtons()
        
        
        //end background and buttons
        
        let bg = background.childNode(withName: "LevelBackground") as! SKSpriteNode
        bg.texture = SKTexture(imageNamed: "bgEnd")
        levelLabel.removeFromParent()
        
        let home = GameButtonNode(image: SKTexture(imageNamed: "home"), onTap: {})
        let foward = GameButtonNode(image: SKTexture(imageNamed: "foward"), onTap: {})
        
        home.position = CGPoint(x: -50 , y: -self.frame.height/2)
        foward.position = CGPoint(x: 50 , y: -self.frame.height/2)
        
        home.zPosition = 1
        foward.zPosition = 1
        
        self.addChild(home)
        self.addChild(foward)
        
        let endLabel = SKLabelNode()
        endLabel.fontSize = self.size.height/40
        endLabel.fontColor = .init(red: 0.2, green: 0.08, blue: 0.22, alpha: 1.0) //50,21,56
        endLabel.text = levelcomplete[levelName]
        endLabel.preferredMaxLayoutWidth = 500
        endLabel.numberOfLines = 0
        endLabel.position = CGPoint(x: 0, y: self.size.height/2 - endLabel.frame.height * 4/3) //
        self.addChild(endLabel)
        //print(numberOfLines(lb: endLabel))
        
        home.run(SKAction.move(to: CGPoint(x: -50 , y: -self.frame.height/2 + 150), duration: 0.7))
        foward.run(SKAction.move(to: CGPoint(x: 50 , y: -self.frame.height/2 + 150), duration: 0.7))
        
    }
    
}



//class FaseLampada: SKScene {
//
//    var background = SKEffectNode()
//    var filament1 : RotateNode!
//    var filament2 : RotateNode!
//    var playing = true
//    var levelLabel : SKLabelNode!
//
//    var hintButton : GameButtonNode!
//    var settingsButton : GameButtonNode!
//
//    let LevelName = LevelState.lamp
//
//
//    override func didMove(to view: SKView) {
//        //
//        levelLabel = SKLabelNode(text: leveltexts[LevelName])
//        levelLabel.fontSize = 40
//        levelLabel.position = CGPoint(x: 0, y: self.frame.height/2 - 120)
//        self.addChild(levelLabel)
//
//        //MARK: Define Blur and hint
//        let blurBackground = SKSpriteNode(imageNamed: "blur")
//        blurBackground.name = "LevelBackGround"
//        let hintPopUp = SKSpriteNode(imageNamed: "hint-bubble")
//        let hintLabel = SKLabelNode(text: hints[LevelName])
//        hintLabel.fontColor = .black
//        let filter = CIFilter(name: "CIGaussianBlur", parameters: ["inputRadius" : NSNumber(value:200.0)])
//        background = SKEffectNode()
//        background.filter = filter
//        background.shouldRasterize = true
//        background.shouldEnableEffects = false
//        background.addChild(blurBackground)
//        background.zPosition = 0
//        self.addChild(background)
//
//        //MARK: Load Sprites and positions
//        setfilaments()
//        setLighting()
//
//        //MARK: Buttons
//        settingsButton = GameButtonNode(image: SKTexture(imageNamed: "settings"), onTap: {})
//        settingsButton.position = CGPoint(x: 270, y: -510)
//        self.addChild(settingsButton)
//        settingsButton.zPosition = 1
//
//        //MARK: Hint and Settings buttons
//        hintButton = GameButtonNode(image: SKTexture(imageNamed: "hint"), onTap: {})
//        hintButton.position = CGPoint(x: -270, y: -510)
//        self.addChild(hintButton)
//        hintButton.zPosition = 1
//
//        hintPopUp.size = CGSize(width: hintPopUp.size.width * 2, height: hintPopUp.size.height * 2)
//        hintPopUp.position = CGPoint(x: hintButton.position.x + hintPopUp.size.width/2, y: hintButton.position.y + hintPopUp.size.height/2)
//        hintPopUp.addChild(hintLabel)
//
//
//        let btnRetry = GameButtonNode(image: SKTexture(imageNamed: "retry"), onTap: {})
//        let btnHome = GameButtonNode(image: SKTexture(imageNamed: "home"), onTap: {})
//        let btnMusic = GameButtonNode(image: SKTexture(imageNamed: "music"), onTap: {})
//
//        let settingsButtons = [btnRetry, btnHome, btnMusic]
//
//
//        //MARK: Buttons Animations
//        var animationsFw : [SKAction] = []
//        let animationBack : SKAction = SKAction.move(to: settingsButton.position, duration: 0.3)
//
//        for i in 0 ..< settingsButtons.count {
//            settingsButtons[i].position = settingsButton.position
//            settingsButtons[i].zPosition = 1
//            animationsFw.append(SKAction.move(to: CGPoint(x: settingsButton.position.x, y: settingsButton.position.y + (CGFloat(i + 1) * (settingsButtons[i].size.height + 30))), duration: 0.3))
//        }
//
//        //MARK: Buttons actions
//
//        hintButton.onTap = { [self] in
//            if !hintButton.pressed {
//                self.blurBackground()
//                self.addChild(hintPopUp)
//                settingsButton.zPosition = -2
//            }
//            else {
//                self.blurBackground()
//                hintPopUp.removeFromParent()
//                settingsButton.zPosition = 1
//            }
//        }
//
//        settingsButton.onTap = { [self] in
//
//            if !settingsButton.pressed {
//                self.blurBackground()
//                settingsButton.run(SKAction.rotate(byAngle: -.pi/2, duration: 0.3))
//
//                for i in 0..<settingsButtons.count {
//                    self.addChild(settingsButtons[i])
//                    settingsButtons[i].run(animationsFw[i])
//                }
//
//                hintButton.zPosition = -3
//            }
//            else{
//                self.blurBackground()
//                settingsButton.run(SKAction.rotate(byAngle: .pi/2, duration: 0.3))
//
//                for i in 0..<settingsButtons.count {
//                    settingsButtons[i].run(animationBack,completion: {
//                        settingsButtons[i].removeFromParent()
//                    })
//                }
//                hintButton.zPosition = 1
//            }
//
//        }
//    }
//
//    //function to blur
//    func blurBackground(){
//        self.background.shouldEnableEffects = !self.background.shouldEnableEffects
//    }
//
//    func setfilaments() {
//        filament1 = RotateNode(imageNamed: "fila1")
//        filament2 = RotateNode(imageNamed: "fila2")
//
//        filament1.position = CGPoint(x: -89, y: -80)
//        filament2.position = CGPoint(x: 67, y: -80)
//
//        filament1.zRotation = .pi/2
//
//        filament1.zPosition = 1
//        filament2.zPosition = 1
//
//        background.addChild(filament1)
//        background.addChild(filament2)
//
//        filament2.rotate()
//        filament2.rotate()
//    }
//
//    //function to transform radians to degrees, returns an int value
//    func rad2deg(_ rad: CGFloat) -> Int {
//        return Int(rad * 180 / 3.14)
//    }
//
//    override func update(_ currentTime: TimeInterval) {
//
//        //Check if still playing ( didn`t align filaments)
//        if playing {
//
//            //Conditions to position the lightining when filament is aligned
//            if (rad2deg(filament1.zRotation) % 360 == 0) {
//                for node in filament1.children {
//                    node.isHidden = false
//                }
//            }
//            else{
//                for node in filament1.children {
//                    node.isHidden = true
//                }
//            }
//
//            if (rad2deg(filament2.zRotation) % 360 == 0) {
//                for node in filament2.children {
//                    node.isHidden = false
//                }
//            }
//            else{
//                for node in filament2.children {
//                    node.isHidden = true
//                }
//            }
//
//            //Compare filaments rotation
//            if (rad2deg(filament1.zRotation) % 360 == 0) && (rad2deg(filament2.zRotation) % 360 == 0) {
//                playing = false
//                endLevel()
//            }
//
//        }
//    }
//
//
//    func setLighting(){
//
//        let lightining = SKSpriteNode(imageNamed: "lighting")
//        filament1.addChild(lightining)
//        lightining.position = CGPoint(x: -40, y: 90)
//        lightining.isHidden = true
//
//        let lightining2 = SKSpriteNode(imageNamed: "lighting")
//        filament2.addChild(lightining2)
//        lightining2.position = CGPoint(x: 0, y: 90)
//        lightining2.isHidden = true
//    }
//
//    func endLevel() {
//        //remove hint and settings buttons
//        hintButton.removeFromParent()
//        settingsButton.removeFromParent()
//
//
//        //end background and buttons
//
//        let bg = background.childNode(withName: "LevelBackGround") as! SKSpriteNode
//        bg.texture = SKTexture(imageNamed: "bgEnd")
//        levelLabel.removeFromParent()
//
//        let home = GameButtonNode(image: SKTexture(imageNamed: "home"), onTap: {})
//        let foward = GameButtonNode(image: SKTexture(imageNamed: "foward"), onTap: {})
//
//        home.position = CGPoint(x: -50 , y: -self.frame.height/2)
//        foward.position = CGPoint(x: 50 , y: -self.frame.height/2)
//
//        home.zPosition = 1
//        foward.zPosition = 1
//
//        self.addChild(home)
//        self.addChild(foward)
//
//        let endLabel = SKLabelNode()
//        endLabel.fontSize = self.size.height/40
//        endLabel.fontColor = .init(red: 0.2, green: 0.08, blue: 0.22, alpha: 1.0) //50,21,56
//        endLabel.text = levelcomplete[LevelName]
//        endLabel.preferredMaxLayoutWidth = 500
//        endLabel.numberOfLines = 0
//        endLabel.position = CGPoint(x: 0, y: self.size.height/2 - endLabel.frame.height * 4/3) //
//        self.addChild(endLabel)
//        //print(numberOfLines(lb: endLabel))
//
//        home.run(SKAction.move(to: CGPoint(x: -50 , y: -self.frame.height/2 + 150), duration: 0.7))
//        foward.run(SKAction.move(to: CGPoint(x: 50 , y: -self.frame.height/2 + 150), duration: 0.7))
//
//    }
//
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
//
//}
//
