//
//  FaseLampada.swift
//  MistakeIt
//
//  Created by IgorMiyamoto on 27/10/20.
//

import SpriteKit

class FaseLampada: SKScene {
    
    var fundo = SKEffectNode()
    var filamento1 : RotateNode!
    var filamento2 : RotateNode!
    var raio : SKSpriteNode!
    var playing = true
    var levelLabel : SKLabelNode!
    
    
    override func didMove(to view: SKView) {
        
        //MARK: Load Sprites and positions
        setFilamentos()
        //setHint
        setLighting()
        
        //m
        levelLabel = SKLabelNode(text: "PlaceHolder")
        levelLabel.fontSize = self.size.height/40
        levelLabel.position = CGPoint(x: 0, y: self.frame.height/2 - 120)
        
        self.addChild(levelLabel)
        
        //MARK: Define Blur and hint
        let blurBackground = SKSpriteNode(imageNamed: "blur")
        let hintPopUp = SKSpriteNode(imageNamed: "hint-bubble")
        let filter = CIFilter(name: "CIGaussianBlur", parameters: ["inputRadius" : NSNumber(value:200.0)])
        fundo = SKEffectNode()
        fundo.filter = filter
        fundo.shouldRasterize = true
        fundo.shouldEnableEffects = false
        fundo.addChild(blurBackground)
        fundo.zPosition = -1
        self.addChild(fundo)
        
        
        //MARK: Hint and Settings buttons
        let btnHint = GameButtonNode(image: SKTexture(imageNamed: "hint"), onTap: {})
        btnHint.position = CGPoint(x: -270, y: -510)
        self.addChild(btnHint)
        
        hintPopUp.position = CGPoint(x: btnHint.position.x + hintPopUp.size.width/2, y: btnHint.position.y + hintPopUp.size.height/2)
        btnHint.onTap = {
            if !btnHint.pressed {
                self.blurBackground()
                self.addChild(hintPopUp)
            }
            else {
                self.blurBackground()
                hintPopUp.removeFromParent()
            }
        }
        
        
        //btnHint.zPosition = 1
        
        let btnSettings = GameButtonNode(image: SKTexture(imageNamed: "settings"), onTap: {
            self.run(SKAction.rotate(byAngle: -.pi/2, duration: 1))
            
        })
        btnSettings.position = CGPoint(x: 270, y: -510)
        self.addChild(btnSettings)
        
        //btnSettings.zPosition = 1
        
        let btnRetry = GameButtonNode(image: SKTexture(imageNamed: "retry"), onTap: {})
        let btnHome = GameButtonNode(image: SKTexture(imageNamed: "home"), onTap: {})
        let btnMusic = GameButtonNode(image: SKTexture(imageNamed: "music"), onTap: {})

        let settingsButtons = [btnRetry, btnHome, btnMusic]

        
        //MARK: Buttons Animations
        var animationsFw : [SKAction] = []
        let animationBack : SKAction = SKAction.move(to: btnSettings.position, duration: 0.3)
//
        for i in 0 ..< settingsButtons.count {
            settingsButtons[i].position = btnSettings.position
            settingsButtons[i].zPosition = 1
            animationsFw.append(SKAction.move(to: CGPoint(x: btnSettings.position.x, y: btnSettings.position.y + (CGFloat(i + 1) * (settingsButtons[i].size.height + 30))), duration: 0.3))
        }
    
        
        btnSettings.onTap = {
            
            if !btnSettings.pressed {
                self.blurBackground()
                btnSettings.run(SKAction.rotate(byAngle: -.pi/2, duration: 0.3))
                
                for i in 0..<settingsButtons.count {
                    self.addChild(settingsButtons[i])
                    settingsButtons[i].run(animationsFw[i])
                }
            }
            else{
                self.blurBackground()
                btnSettings.run(SKAction.rotate(byAngle: .pi/2, duration: 0.3))
                
                for i in 0..<settingsButtons.count {
                    settingsButtons[i].run(animationBack,completion: {
                        settingsButtons[i].removeFromParent()
                    })
                }
            }
            
        }
    }
    
    //function to blur
    func blurBackground(){
        self.fundo.shouldEnableEffects = !self.fundo.shouldEnableEffects
    }
    
    func setFilamentos() {
        filamento1 = RotateNode(imageNamed: "fila1")
        filamento2 = RotateNode(imageNamed: "fila2")
        
        filamento1.position = CGPoint(x: -89, y: -80)
        filamento2.position = CGPoint(x: 67, y: -80)
        
        filamento1.zRotation = .pi/2
        
        self.addChild(filamento1)
        self.addChild(filamento2)
        
        //filamento1.rotate()
        filamento2.rotate()
        filamento2.rotate()
    }
    
    //function to transform radians to degrees, returns an int value
    func rad2deg(_ rad: CGFloat) -> Int {
        return Int(rad * 180 / 3.14)
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        if playing {
            if (rad2deg(filamento1.zRotation) % 360 == 0) {
                for node in filamento1.children {
                    node.isHidden = false
                }
            }
            else{
                for node in filamento1.children {
                    node.isHidden = true
                }
            }

            if (rad2deg(filamento2.zRotation) % 360 == 0) {
                for node in filamento2.children {
                    node.isHidden = false
                }
            }
            else{
                for node in filamento2.children {
                    node.isHidden = true
                }
            }
            
            //Comparação da rotação dos dois filamentos
            if (rad2deg(filamento1.zRotation) % 360 == 0) && (rad2deg(filamento2.zRotation) % 360 == 0) {
                playing = false
                endLevel()
            }

        }
    }
    
    
    func setLighting(){
        
        let raio = SKSpriteNode(imageNamed: "lighting")
        filamento1.addChild(raio)
        raio.position = CGPoint(x: -40, y: 90)
        raio.isHidden = true
        
        let raio2 = SKSpriteNode(imageNamed: "lighting")
        filamento2.addChild(raio2)
        raio2.position = CGPoint(x: 0, y: 90)
        raio2.isHidden = true
    }
    
    func endLevel() {
        //remove os botoes de hint e  config
        
        //...
        
        //puxa a tela final e os botoes
        let bg = self.childNode(withName: "bg") as! SKSpriteNode
        
        //bg.run(SKAction.)
        bg.texture = SKTexture(imageNamed: "bgEnd")
        fundo.removeFromParent()
        
        let home = GameButtonNode(image: SKTexture(imageNamed: "home"), onTap: {})
        let foward = GameButtonNode(image: SKTexture(imageNamed: "foward"), onTap: {})
        
        
        home.position = CGPoint(x: -50 , y: -self.frame.height/2)
        foward.position = CGPoint(x: 50 , y: -self.frame.height/2)
        
        self.addChild(home)
        self.addChild(foward)
        
        
        let endLabel = SKLabelNode()
        endLabel.fontSize = self.size.height/40
        endLabel.position = CGPoint(x: 0, y: 400)
        endLabel.fontColor = .init(red: 0.2, green: 0.08, blue: 0.22, alpha: 1.0) //50,21,56
        endLabel.text = "Placeholder"
        self.addChild(endLabel)
        
        
        home.run(SKAction.move(to: CGPoint(x: -50 , y: -self.frame.height/2 + 150), duration: 0.7))
        foward.run(SKAction.move(to: CGPoint(x: 50 , y: -self.frame.height/2 + 150), duration: 0.7))
        
    }
}
