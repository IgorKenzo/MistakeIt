//
//  FasePenicilina.swift
//  MistakeIt
//
//  Created by IgorMiyamoto on 11/11/20.
//

import SpriteKit

//Masks to collision
struct CategoryMasks : OptionSet {
    let rawValue: UInt32
    init(rawValue: UInt32) { self.rawValue = rawValue }
    
    static let fungus = CategoryMasks(rawValue: 0x1 << 0)
    static let bacteria = CategoryMasks(rawValue: 0x1 << 1)
}

class FasePenicilina : SKScene, SKPhysicsContactDelegate, CommonProperties, SceneManager {
    //Protocol
    var levelLabel: SKLabelNode!
    
    var levelName: LevelState!
    
    var background: SKEffectNode!
    
    var settingsButton: GameButtonNode!
    
    var hintButton: GameButtonNode!
    
    //Level Specific
    private var currentNode: SKNode?    
    var fungus : SKSpriteNode!
    private var numBac : Int!
    private var playing = true
    private var finalText : SKSpriteNode = SKSpriteNode(imageNamed: "completiontextpenicilin")
    var playaudio : SKAction!
    
    override func didMove(to view: SKView) {
        //Contact
        physicsWorld.contactDelegate = self
        
        //MARK: setting the common properties
        setLevelName(name: .peni)
        setBackground(bgImg: SKSpriteNode(imageNamed: "2-bg"))
        addLevelLabel()
        setButtons(retry: {self.loadScene(withIdentifier: self.levelName)})
        addButtons()
        
        playaudio = SKAction.playSoundFileNamed("bacteria_01", waitForCompletion: false)
        
//        let c = SKShapeNode(circleOfRadius: self.frame.width/2 - 50)
//        c.position = CGPoint(x: 0, y: -20)
//        c.strokeColor = .red
//        c.zPosition = 20
//        background.addChild(c)
        
        fungus = SKSpriteNode(imageNamed: "2-fungo")//fungo
        fungus.position = CGPoint(x: 0, y: 0)
        fungus.size = CGSize(width: fungus.size.width/5, height: fungus.size.height/5)
        fungus.physicsBody = SKPhysicsBody(rectangleOf: fungus.size)
        fungus.physicsBody?.categoryBitMask = CategoryMasks.fungus.rawValue
        fungus.physicsBody?.collisionBitMask = CategoryMasks.bacteria.rawValue
        fungus.physicsBody?.contactTestBitMask = CategoryMasks.bacteria.rawValue
        fungus.physicsBody?.affectedByGravity = false
        fungus.name = "fungus"
        fungus.zPosition = 2
        fungus.position = CGPoint.zero
        background.addChild(fungus)
        
        numBac = 8
        for _ in 0 ..< numBac {
            spawnBac()
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            let touchedNodes = self.nodes(at: location)
            for node in touchedNodes.reversed() {
                if node.name == "fungus" {
                    self.currentNode = node
                    
                }
            }
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, let node = self.currentNode {
            let touchLocation = touch.location(in: self)
            let baseRadius = self.frame.width/2 - 50
            let distance = sqrt(pow(touchLocation.x, 2) + pow(touchLocation.y + 20, 2))
            let distanceDiff = distance - baseRadius
            

            if distanceDiff > 0 {
                let handlePosition = CGPoint(x: touchLocation.x / distance * baseRadius, y: touchLocation.y / distance * baseRadius)
                node.position = handlePosition
            } else {
                node.position = touchLocation
            }
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.currentNode = nil
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        contact.bodyB.node?.removeFromParent()
        HapticsFeedback.shared.vibrate()
        numBac -= 1
        self.run(playaudio)
//            audios["bacteria_01"]?.play()
        //audios["comecome"]!.play()
    }
    
    
    
    func spawnBac() {
        let radius = CGFloat.random(in: fungus.size.width ... self.frame.width/2)
        let angle = CGFloat.random(in: 0 ... 2 * .pi)
        let position = CGPoint(x: radius * cos(angle), y: radius * sin(angle))
        
        
        let bac = SKSpriteNode(imageNamed: "2-bacteria")
        bac.name = "bac"
        bac.position = position
        bac.size = CGSize(width: bac.size.width/6, height: bac.size.height/6)
        bac.physicsBody = SKPhysicsBody(rectangleOf: bac.size)
        bac.physicsBody?.categoryBitMask = 0x1 << 1
        bac.physicsBody?.collisionBitMask = 0x1 << 0
        bac.physicsBody?.affectedByGravity = false
        bac.physicsBody?.isDynamic = false
        bac.physicsBody?.allowsRotation = false
        bac.zPosition = 1
        background.addChild(bac)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if playing {
            if numBac == 0 {
                fungus.removeFromParent()
                endLevel(fowardDestination: {self.loadScene(withIdentifier: .paper)})
                playing = false
                finalText.position = CGPoint(x: 0, y: 50)
                finalText.zPosition = 1
                //finalText.setScale(0.9)
                self.addChild(finalText)
            }
        }
    }
    
    
//    func endGame(){
//        removeButtons()
//        removeLevelLabel()
//
//        let endLabel = SKLabelNode()
//        endLabel.fontSize = self.size.height/40
//        endLabel.fontColor = .brown// .init(red: 0.2, green: 0.08, blue: 0.22, alpha: 1.0) //50,21,56
//        endLabel.text = levelcomplete[levelName]
//        endLabel.preferredMaxLayoutWidth = 700
//        endLabel.numberOfLines = 0
//        endLabel.position = CGPoint(x: 0, y: self.size.height/2 - endLabel.frame.height * 4/3) //
//        endLabel.zPosition = 1
//        self.addChild(endLabel)
//    }
}


//extension UIColor {
//    static func random() -> UIColor {
//        return UIColor(
//            red:   CGFloat.random(in: 0...1),
//            green: CGFloat.random(in: 0...1),
//            blue:  CGFloat.random(in: 0...1),
//                    alpha: 1.0
//                )
//    }
//}
