//
//  GameScene.swift
//  ProjetoErro
//
//  Created by IgorMiyamoto on 14/10/20.
//

import SpriteKit
import GameplayKit



class PaperScene: SKScene, SKPhysicsContactDelegate, CommonProperties, SceneManager {
    
    //Protocol
    var levelLabel: SKLabelNode!
    var levelName: LevelState!
    
    var background: SKEffectNode!
    var settingsButton: GameButtonNode!
    var hintButton: GameButtonNode!
    
    // Level Specific
    var imageArray : [Paper] = []
    var boxArray: [SKSpriteNode] = []
    var levelFinished : Bool = false
    var finalBox = SKSpriteNode(imageNamed: "3-quadro")
    var finalText : SKSpriteNode = SKSpriteNode(imageNamed: "completiontextpaper")
    var actualNode : SKSpriteNode! // variable to receive the ordem of an array and compare with the array position
    
    
    override func didMove(to view: SKView) {
        
        setLevelName(name: .paper)
        setBackground(bgImg: SKSpriteNode(imageNamed: "bg2"))
        
        addLevelLabel()
        setButtons()
        addButtons()
        
        //method to fill the array of nodes with the paper images and add the nodes into the view
        for i in 0...11{
            imageArray.append(Paper(imageNamed: "\(i)"))
            imageArray[i].name = String(i)
            imageArray[i].position = CGPoint(x: 0, y: -400) //posiciona o adesivo no centro, na parte de baixo da tela
            imageArray[i].zPosition = 1
            self.physicsWorld.gravity = CGVector(dx: 0, dy: 0) //determina que a gravidade sobre o formato do papel será estática sobre o eixo x-y
            self.physicsWorld.contactDelegate = self
        }
        
        imageArray.shuffle()
        
        for i in 0...11{
            background.addChild(imageArray[i])
        }
        
        
        // value for the position x axe of each box that will be used to compared the final position of each paper
        var alpha : Int = -300
        // value for the position y axe of each box that will be used to compared the final position of each paper
        var beta : Int = 350
        //method to create the array of boxes nodes and add them into the view
        for k in 0...11 {
            boxArray.append(SKSpriteNode(color: .init(white: 10, alpha: 0), size: CGSize(width: 300, height: 300)))
            boxArray[k].position = CGPoint(x: alpha, y: beta)
            boxArray[k].physicsBody?.isDynamic = false //make the node static to reduce CPU use
            background.addChild(boxArray[k])
            
            //method to create the correct position of each following box node
            if (k == 3 || k == 7) {
                alpha = alpha - 600
                beta = beta - 150
            }
            else {
                alpha = alpha + 200
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        let touchLocation = touch?.location(in: self)
        let nodes = self.nodes(at: touchLocation!)
        
        //check if the node selected is a SKSpriteNode
        let selectednode = nodes.compactMap({nodeontop in
                                                nodeontop as? Paper})
        
        //method to move the first node on the pile of nodes created on the same position (gets the last node created)
        if let firstnode = selectednode.first {
                actualNode = firstnode
        }
    }
    
    // method to move the paper node once the user touches over it
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        let touchLocation = touch?.location(in: self)
        
        if let node = actualNode {
            let i = imageArray.firstIndex(of: node as! Paper)
            imageArray[i!].position = touchLocation!

        }
    }
    
    //method to end the movement of the nodes whenever the user stop touching the screen
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        actualNode = nil
        //call the method to check the level everytime the user finishes touching the screen
        if (levelFinished != true){
            checkLevel()
        }
    }

    //method to check if the user finished the level
    func checkLevel () {
        
        checkNodes()
        if (levelFinished) {
            endLevelPaper()
        }
    }
    
    //method to check if the paper nodes are in their correct position, compared to the box nodes created previously
    func checkNodes() {

        var nodeIntersect = Array(repeating: false, count: 12) //boolean array used to check if each node is movedto the right position

        for i in 0...11{
            if (imageArray[i].frame.intersects(boxArray[Int(imageArray[i].name!)!].frame)){
                nodeIntersect[Int(imageArray[i].name!)!] = true
            }
        }
        
        //if the nodes with drawing are on the correct positions, define the boolean levelFinished to true
        if (nodeIntersect[1] == true && nodeIntersect[2] == true && nodeIntersect[4] == true && nodeIntersect[5] == true && nodeIntersect[6] == true && nodeIntersect[7] == true && nodeIntersect[9] == true && nodeIntersect[10] == true){
            levelFinished = true
        }
    }
    
    //method when the user finishes the level
    func endLevelPaper() {
        
        //remove the paper and boxes nodes
        for i in 0...11{
            imageArray[i].removeFromParent()
            boxArray[i].removeFromParent()
        }
        
        //set the position and add the node with the explanation text
        finalText.position = CGPoint (x: 0, y: 180)
        finalText.setScale(0.24)
        finalText.zPosition = 2
        self.addChild(finalText)
        
        //call the method on CommonProperties to send the user to the next stage
        endLevel(fowardDestination: {self.loadScene(withIdentifier: .pace)})
    }
   
}
