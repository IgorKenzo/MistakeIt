//
//  Pacemaker.swift
//  MistakeIt
//
//  Created by IgorMiyamoto on 17/11/20.
//

import SpriteKit

class Pacemaker: SKScene, SKPhysicsContactDelegate, CommonProperties {
    
    var levelName: LevelState!
    
    var settingsButton: GameButtonNode!
    
    var hintButton: GameButtonNode!
    
    var background: SKEffectNode!
    
    var levelLabel: SKLabelNode!
    
    //Level Specific
    private var currentNode: SKSpriteNode?
    private var fio1 : SKSpriteNode!
    private var fio2 : SKSpriteNode!
    private var fio3 : SKSpriteNode!
    
    
    private var tool : SKSpriteNode!
    var heartbeatblue : SKSpriteNode = SKSpriteNode(imageNamed: "bluewave")
    var heartbeatgreen : SKSpriteNode = SKSpriteNode(imageNamed: "greenwave")
    var heartbeatred : SKSpriteNode = SKSpriteNode(imageNamed: "redwave")
    
    
    override func didMove(to view: SKView) {
        //Contact
        physicsWorld.contactDelegate = self
        
        //MARK: setting the common properties
//        setLevelName(name: .pace)
//        setBackground(bgImg: SKSpriteNode(color: .clear, size: self.size))
//        addLevelLabel()
//        setButtons()
//        addButtons()
        
        setBackground(bgImg: SKSpriteNode(imageNamed: "bg2"))

        tool = SKSpriteNode(imageNamed: "tool")
        self.addChild(tool)
        self.addChild(heartbeatblue)
        self.addChild(heartbeatgreen)
        self.addChild(heartbeatred)

        
        fio1 = self.childNode(withName: "bg")!.childNode(withName: "bluewire") as! SKSpriteNode
        fio2 = self.childNode(withName: "bg")!.childNode(withName: "greenwire") as! SKSpriteNode
        fio3 = self.childNode(withName: "bg")!.childNode(withName: "redwire") as! SKSpriteNode
        
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
    }
    
    
    func intersect() -> Bool {
        if (tool.frame.intersects(fio1.frame)){
            fio1.removeFromParent()
            increaseHeartBeat(heartbeat : heartbeatblue)
            return
        }
        if (tool.frame.intersects(fio2.frame)) {
            fio2.removeFromParent()
            increaseHeartBeat(heartbeat : heartbeatgreen)
            return
        }
        if (tool.frame.intersects(fio3.frame)) {
            fio3.removeFromParent()
            increaseHeartBeat(heartbeat : heartbeatred)
            return
        }
        
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
        
        removeButtons()
        removeLevelLabel()
        
        let endLabel = SKLabelNode()
        endLabel.fontSize = self.size.height/40
        endLabel.fontColor = .white
        endLabel.text = levelcomplete[levelName]
        endLabel.preferredMaxLayoutWidth = 700
        endLabel.numberOfLines = 0
        endLabel.position = CGPoint(x: 0, y: 0)
        endLabel.zPosition = 1
        self.addChild(endLabel)
    }

    

    func didBegin(_ contact: SKPhysicsContact) {
        //print(contact.bodyB)
    }
    
}
