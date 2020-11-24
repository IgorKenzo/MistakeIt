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
    
    func touchUp(atPoint pos : CGPoint) {
        endedLocation = pos
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.currentNode = nil
    }
    
    
    func intersect() -> Bool {
        if (wire1.frame.intersects(tool.frame)){
            wire1.removeFromParent()
        }
        if (endedLocation == wire1.position){
            wire1.removeFromParent()
        }
        if (tool.frame.intersects(wire1.frame)){
            wire1.removeFromParent()
            increaseHeartBeat(heartbeat : heartbeatblue)
            check = true
            return check
        }
        if (tool.frame.intersects(wire2.frame)) {
            wire2.removeFromParent()
            increaseHeartBeat(heartbeat : heartbeatgreen)
            check = true
            return check
        }
        if (tool.frame.intersects(wire3.frame)) {
            wire3.removeFromParent()
            increaseHeartBeat(heartbeat : heartbeatred)
            check = true
            return check
        }
        return check
    }
    

    func heartbeat () {
        let fadeOut = SKAction.fadeOut(withDuration: 1)
        heartbeatblue.run(fadeOut)
        heartbeatgreen.run(fadeOut)
        heartbeatred.run(fadeOut)
    }
    
    func increaseHeartBeat (heartbeat : SKSpriteNode) {
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        heartbeat.run(fadeOut)
    }
    
    func checkLevel() {
        if (intersect()){
            endLevel()
        }
        else {
            heartbeat()
            //precisa colocar um método de recolocar os fios e o alicate na posição correta.
        }
    }
    

    func endLevel () {
        heartbeatgreen.removeFromParent()
        heartbeatgreen.removeFromParent()
        heartbeatred.removeFromParent()
        tool.removeFromParent()
        heart.removeFromParent()
        
        endLevel(fowardDestination: {self.loadScene(withIdentifier: .credits)})
        
    }


}
