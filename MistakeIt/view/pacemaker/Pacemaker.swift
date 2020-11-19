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
    
    override func didMove(to view: SKView) {
        //Contact
        physicsWorld.contactDelegate = self
        
        //MARK: setting the common properties
//        setLevelName(name: .pace)
//        setBackground(bgImg: SKSpriteNode(color: .clear, size: self.size))
//        addLevelLabel()
//        setButtons()
//        addButtons()
        
//        fio1 = self.childNode(withName: "bg")!.childNode(withName: "fio1") as! SKSpriteNode
//        fio2 = self.childNode(withName: "bg")!.childNode(withName: "fio2") as! SKSpriteNode
//        fio3 = self.childNode(withName: "bg")!.childNode(withName: "fio3") as! SKSpriteNode
        
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
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        //print(contact.bodyB)
    }
    
}
