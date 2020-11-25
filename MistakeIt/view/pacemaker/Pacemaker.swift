//
//  Pacemaker.swift
//  MistakeIt
//
//  Created by IgorMiyamoto on 17/11/20.
//

import SpriteKit

class Pacemaker: SKScene, SKPhysicsContactDelegate, CommonProperties, SceneManager {
    
    var levelName: LevelState!
    
    var settingsButton: GameButtonNode!
    
    var hintButton: GameButtonNode!
    
    var background: SKEffectNode!
    
    var levelLabel: SKLabelNode!
    
    //Level Specific
    private var currentNode: SKSpriteNode?
    private var wire1 : SKSpriteNode!
    private var wire2 : SKSpriteNode!
    private var wire3 : SKSpriteNode!
    private var monitor : SKSpriteNode!
    var check : Bool = false
    private var heart : SKSpriteNode!
    private var tool : SKSpriteNode!
    var heartbeatblue : SKSpriteNode = SKSpriteNode(imageNamed: "bluewave")
    var heartbeatgreen : SKSpriteNode = SKSpriteNode(imageNamed: "greenwave")
    var heartbeatred : SKSpriteNode = SKSpriteNode(imageNamed: "redwave")
    private var box : SKSpriteNode!
    private var endedLocation : CGPoint!
    
    var finalText : SKSpriteNode = SKSpriteNode(imageNamed: "completiontextpace")

    
    override func didMove(to view: SKView) {
        //Contact
        physicsWorld.contactDelegate = self
        
        //MARK: setting the common properties
        setLevelName(name: .pace)
        setBackground(bgImg: SKSpriteNode(color: .clear, size: self.size))
        addLevelLabel()
        setButtons()
        addButtons()
        
        monitor = SKSpriteNode(imageNamed: "4-monitor")
        monitor.position = CGPoint(x: 0, y: 350)
        monitor.setScale(0.28)
  //      monitor.zPosition = 1
        background.addChild(monitor)
        
        heart = SKSpriteNode(imageNamed: "corasson")
        heart.position = CGPoint(x: 800, y: 200)
  //      heart.zPosition = 2
        monitor.addChild(heart)

        heartbeatblue = SKSpriteNode(imageNamed: "bluewave")
        heartbeatblue.setScale(5)
        heartbeatblue.position = CGPoint(x: -500, y: 550)
  //      heartbeatblue.zPosition = 2
        monitor.addChild(heartbeatblue)
        
        heartbeatgreen = SKSpriteNode(imageNamed: "greenwave")
        heartbeatgreen.setScale(5)
        heartbeatgreen.position = CGPoint(x: -500, y: -550)
  //      heartbeatgreen.zPosition = 2
        monitor.addChild(heartbeatgreen)
        
        heartbeatred = SKSpriteNode(imageNamed: "redwave")
        heartbeatred.setScale(5)
        heartbeatred.position = CGPoint(x: -500, y: 0)
  //      heartbeatred.zPosition = 2
        monitor.addChild(heartbeatred)
        
        box = SKSpriteNode(imageNamed: "box")
        box.position = CGPoint(x: 0, y: -350)
        box.setScale(1.2)
        box.zPosition = 1
        background.addChild(box)
        
        tool = SKSpriteNode(imageNamed: "tool")
        tool.name = "drag"
        tool.setScale(0.25)
        tool.position = CGPoint(x: -235, y: 0)
        tool.zPosition = 1
        box.addChild(tool)
        
        wire1 = SKSpriteNode(imageNamed: "bluewire")
        wire1.zRotation = 1
        wire1.position = CGPoint(x: 250, y: 0)
        wire1.zPosition = 1
        box.addChild(wire1)
        
        wire2 = SKSpriteNode(imageNamed: "greenwire")
        wire2.zRotation = 1.7
        wire2.position = CGPoint(x: -50, y: 0)
        wire2.zPosition = 1
        box.addChild(wire2)
        
        wire3 = SKSpriteNode(imageNamed: "redwire")
        wire3.zRotation = 1
        wire3.position = CGPoint(x: 150, y: 0)
        wire3.zPosition = 1
        box.addChild(wire3)
        
        heartbeat(heartbeat: heartbeatblue)
        heartbeat(heartbeat: heartbeatgreen)
        heartbeat(heartbeat: heartbeatred)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            let touchedNodes = self.nodes(at: location)
            for node in touchedNodes.reversed() {
                if node.name == "drag" {
                    self.currentNode = node as? SKSpriteNode
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, let node = self.currentNode {
            let touchLocation = touch.location(in: self)
            node.position = touchLocation
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.currentNode = nil
        intersect()
        checkLevel()
        tool.position = CGPoint(x: -235, y: 0)

    }
    
    
    func intersect() -> Bool {
        
        if (tool.frame.intersects(wire1.frame)){
            wire1.isHidden = true
            increaseHeartBeat(heartbeat : heartbeatblue)
            Timer.scheduledTimer(withTimeInterval: 4, repeats: false) {timer in
                self.wire1.isHidden = false
                self.heartbeat(heartbeat: self.heartbeatblue)
            }
            check = false
            return check
        }
        if (tool.frame.intersects(wire2.frame)) {
            wire2.isHidden = true
            increaseHeartBeat(heartbeat : heartbeatgreen)
            Timer.scheduledTimer(withTimeInterval: 4, repeats: false) {timer in
                self.wire2.isHidden = false
                self.heartbeat(heartbeat: self.heartbeatgreen)
            }
            check = true
            return check
        }
        if (tool.frame.intersects(wire3.frame)) {
            wire3.isHidden = true
            increaseHeartBeat(heartbeat : heartbeatred)
            Timer.scheduledTimer(withTimeInterval: 4, repeats: false) {timer in
                self.wire3.isHidden = false
                self.heartbeat(heartbeat: self.heartbeatred)
            }
            check = false
            return check
        }
        return check
    }
    

    func heartbeat (heartbeat :  SKSpriteNode) {
        
        let fadeIn = SKAction.fadeIn(withDuration: 0.9)
        let fadeOut = SKAction.fadeOut(withDuration: 0.9)
        let fadeSequence = SKAction.sequence([fadeIn, fadeOut])
        heartbeat.run(SKAction.repeatForever(fadeSequence))
        
        let scaleUp = SKAction.scale(to: 1.2, duration: 0.2)
        let scaleDown = SKAction.scale(to: 1, duration: 0.2)
        let scaleSequence = SKAction.sequence([scaleUp, scaleDown])
        
        heart.run(SKAction.repeatForever(scaleSequence))
        
        if (intersect()){
            heartbeatblue.run(SKAction.stop())
        }
    }
    
    func increaseHeartBeat (heartbeat : SKSpriteNode) {
        let fadeIn = SKAction.fadeIn(withDuration: 0.09)
        let fadeOut = SKAction.fadeOut(withDuration: 0.09)
        let fadeSequence = SKAction.sequence([fadeIn, fadeOut])
        heartbeat.run(SKAction.repeatForever(fadeSequence))
    }
    
    func checkLevel() {
        if (intersect()){
            endLevel()
        }
        
    }
    

    func endLevel () {
        heartbeatblue.removeFromParent()
        heartbeatgreen.removeFromParent()
        heartbeatred.removeFromParent()
        tool.removeFromParent()
        heart.removeFromParent()
        wire1.removeFromParent()
        wire2.removeFromParent()
        wire3.removeFromParent()
        finalText.position = CGPoint (x: 0, y: 0)
        finalText.setScale(0.8)
        monitor.addChild(finalText)
        endLevel(fowardDestination: {self.loadScene(withIdentifier: .credits)})
        
    }


}
