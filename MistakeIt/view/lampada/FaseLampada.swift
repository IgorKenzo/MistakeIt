//
//  FaseLampada.swift
//  MistakeIt
//
//  Created by IgorMiyamoto on 27/10/20.
//

import SpriteKit
import AVFoundation
class FaseLampada: SKScene, CommonProperties, SceneManager {
    
    //Protocol
    var levelName: LevelState!
    
    var settingsButton: GameButtonNode!
    
    var hintButton: GameButtonNode!
    
    var background: SKEffectNode!
    
    var levelLabel: SKLabelNode!
    
    //Level Specific
    var filament1 : RotateNode!
    var filament2 : RotateNode!
    var playing = true
    
    var finalText : SKSpriteNode = SKSpriteNode(imageNamed: "completiontextlamp")
    
    var playaudio : SKAction!
    
    override func didMove(to view: SKView) {
        
        //MARK: setting the common properties
        setLevelName(name: .lamp)
        setBackground(bgImg: SKSpriteNode(imageNamed: "blur"))
        setButtons(retry: {self.loadScene(withIdentifier: self.levelName)})
        addButtons()
        addLevelLabel()
        
        //MARK: Load Sprites and positions
        setfilaments()
        setLighting()
        
        playaudio = SKAction.playSoundFileNamed("raio_01", waitForCompletion: false)
    }
    
    //Setting Filaments
    func setfilaments() {
        filament1 = RotateNode(imageNamed: "fila1")
        filament2 = RotateNode(imageNamed: "fila2")
        
        filament1.size = CGSize(width: 145, height: 78)
        filament2.size = CGSize(width: 145, height: 78)
        
        filament1.position = CGPoint(x: -69, y: -110)
        filament2.position = CGPoint(x: 67, y: -110)
        
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
               
   //             audios["raio_01"]?.play()
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
                
  //              audios["raio_01"]?.play()
            }
            else{
                for node in filament2.children {
                    node.isHidden = true
                }
            }
            
            //Compare filaments rotation
            if (rad2deg(filament1.zRotation) % 360 == 0) && (rad2deg(filament2.zRotation) % 360 == 0) {
                
                playing = false
                filament1.isUserInteractionEnabled = false
                filament2.isUserInteractionEnabled = false
                filament1.zPosition = 2
                filament2.zPosition = 2
                
//                endLevel(backgroundImage: SKTexture(imageNamed: "bgEnd"), fowardDestination: {self.loadScene(withIdentifier: .peni)})
                
                let bgend = SKSpriteNode(imageNamed: "bgEnd")
                
                bgend.zPosition = 1
                self.addChild(bgend)
                endLevel(fowardDestination: {self.loadScene(withIdentifier: .peni)})
                finalText.position = CGPoint(x: 0, y: 400)
                finalText.zPosition = 2
                finalText.setScale(0.25)
                self.addChild(finalText)
            }

        }
    }
    
    //Setting the lighting that shows when filament is right
    func setLighting(){
        
        let lightining = SKSpriteNode(imageNamed: "lighting")
        lightining.size = CGSize(width: 50, height: 90)
        filament1.addChild(lightining)
        lightining.position = CGPoint(x: -10, y: 90)
        lightining.isHidden = true
        
        let lightining2 = SKSpriteNode(imageNamed: "lighting")
        lightining2.size = CGSize(width: 50, height: 90)
        filament2.addChild(lightining2)
        lightining2.position = CGPoint(x: 0, y: 90)
        lightining2.isHidden = true
    }
 
}
