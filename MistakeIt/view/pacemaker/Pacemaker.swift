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
    
    var checkbox1 : SKSpriteNode = SKSpriteNode(color: .init(white: 1, alpha: 1), size: CGSize(width: 80, height: 400))
    var checkbox2 : SKSpriteNode! = SKSpriteNode(color: .init(white: 1, alpha: 1), size: CGSize(width: 80, height: 400))
    var checkbox3 : SKSpriteNode! = SKSpriteNode(color: .init(white: 1, alpha: 1), size: CGSize(width: 80, height: 400))
    
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
        background.addChild(monitor)
        
        heart = SKSpriteNode(imageNamed: "corasson")
        heart.position = CGPoint(x: 800, y: 200)
        monitor.addChild(heart)

        heartbeatblue = SKSpriteNode(imageNamed: "bluewave")
        heartbeatblue.setScale(5)
        heartbeatblue.position = CGPoint(x: -500, y: 550)
        monitor.addChild(heartbeatblue)
        
        heartbeatgreen = SKSpriteNode(imageNamed: "greenwave")
        heartbeatgreen.setScale(5)
        heartbeatgreen.position = CGPoint(x: -500, y: -550)
        monitor.addChild(heartbeatgreen)
        
        heartbeatred = SKSpriteNode(imageNamed: "redwave")
        heartbeatred.setScale(5)
        heartbeatred.position = CGPoint(x: -500, y: 0)
        monitor.addChild(heartbeatred)
        
        box = SKSpriteNode(imageNamed: "box")
        box.position = CGPoint(x: 0, y: -350)
        box.setScale(1.2)
        box.zPosition = 1
        background.addChild(box)
        
        tool = SKSpriteNode(imageNamed: "tool")
        tool.name = "drag"
        tool.setScale(0.2)
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
    
    //method to allow movement to the pliers tool
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
    
    // method to move the pliers tool node once the user touches over it
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first, let node = self.currentNode {
            let touchLocation = touch.location(in: self)
            node.position = touchLocation
        }
    }
    
    //method to end the movement of the nodes whenever the user stop touching the screen
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.currentNode = nil
        
        //call the method to check the intersection
        intersect()
        
        //restore the tool position node to its initial position
        tool.position = CGPoint(x: -235, y: 0)
    }
    
    //method to check if the tool node are intersects with the wires nodes
    func intersect() {
        
        if (tool.frame.intersects(wire1.frame)){
            //hidde the wire node
            wire1.isHidden = true
            //call the method to increase the heart beat speed
            increaseHeartBeat(heartbeat : heartbeatblue)
            //creates a time interval without action. after it, restore the view of the hidden wire and restore the normal speed of the heart beat
            Timer.scheduledTimer(withTimeInterval: 4, repeats: false) {timer in
                self.wire1.isHidden = false
                self.heartbeat(heartbeat: self.heartbeatblue)
            }
            check = false
        }
        
        if (tool.frame.intersects(wire2.frame)) {
            //hidde the wire node
            wire2.isHidden = true
            //call the method to increase the heart beat speed
            increaseHeartBeat(heartbeat : heartbeatgreen)
            //creates a time interval without action. after it, restore the view of the hidden wire and restore the normal speed of the heart beat
            Timer.scheduledTimer(withTimeInterval: 4, repeats: false) {timer in
                self.wire2.isHidden = false
                self.heartbeat(heartbeat: self.heartbeatgreen)
            }
            check = true
            endLevelPace()
        }
        
        if (tool.frame.intersects(wire3.frame)) {
            //hidde the wire node
            wire3.isHidden = true
            //call the method to increase the heart beat speed
            increaseHeartBeat(heartbeat : heartbeatred)
            //creates a time interval without action. after it, restore the view of the hidden wire and restore the normal speed of the heart beat
            Timer.scheduledTimer(withTimeInterval: 4, repeats: false) {timer in
                self.wire3.isHidden = false
                self.heartbeat(heartbeat: self.heartbeatred)
            }
            check = false
        }
    }
    
    //method to stablishe the speed of time the hearbeat image nodes will fade in and out of the screen and the heart image node will increase and decrease scale
    func heartbeat (heartbeat :  SKSpriteNode) {
        
        let fadeIn = SKAction.fadeIn(withDuration: 0.9)
        let fadeOut = SKAction.fadeOut(withDuration: 0.9)
        let fadeSequence = SKAction.sequence([fadeIn, fadeOut])
        heartbeat.run(SKAction.repeatForever(fadeSequence))
        
        let scaleUp = SKAction.scale(to: 1.2, duration: 0.2)
        let scaleDown = SKAction.scale(to: 1, duration: 0.2)
        let scaleSequence = SKAction.sequence([scaleUp, scaleDown])
        
        heart.run(SKAction.repeatForever(scaleSequence))
        
        if (check == true){
            heartbeatblue.run(SKAction.stop())
        }
    }
    
    
    //method to stablishe the accelerated speed of time the hearbeat image nodes will fade in and out of the screen
    func increaseHeartBeat (heartbeat : SKSpriteNode) {
        let fadeIn = SKAction.fadeIn(withDuration: 0.09)
        let fadeOut = SKAction.fadeOut(withDuration: 0.09)
        let fadeSequence = SKAction.sequence([fadeIn, fadeOut])
        heartbeat.run(SKAction.repeatForever(fadeSequence))
    }
    
    //method when the user finishes the level
    func endLevelPace () {

        //remove the nodes of the screen
        monitor.removeFromParent()
        heartbeatblue.removeFromParent()
        heartbeatgreen.removeFromParent()
        heartbeatred.removeFromParent()
        tool.removeFromParent()
        heart.removeFromParent()
        wire1.removeFromParent()
        wire2.removeFromParent()
        wire3.removeFromParent()
        
        //set the position and add the node with the explanation text
        finalText.position = CGPoint (x: 0, y: 400)
        finalText.setScale(0.25)
        self.addChild(finalText)
        
        //call the method on CommonProperties to send the user to the credits screen
        endLevel(fowardDestination: {self.loadScene(withIdentifier: .credits)})
    }
    
}
