//
//  GameScene.swift
//  ProjetoErro
//
//  Created by IgorMiyamoto on 14/10/20.
//

import SpriteKit
import GameplayKit



class PaperScene: SKScene, SKPhysicsContactDelegate, CommonProperties {
    
    //Protocol
    var levelLabel: SKLabelNode!
    var levelName: LevelState!
    
    var background: SKEffectNode!
    var settingsButton: GameButtonNode!
    var hintButton: GameButtonNode!
    
    // Level Specific
 //   let bgimg = SKSpriteNode(imageNamed: "bg") //atribui a imagem à variável de fundo
    var paper : SKSpriteNode?
    var actual : Int! // variável para recebimento da ordem das imagens da array e depois comparar com posição / ordem etc.
    var text: SKLabelNode!
    var imageArray : [SKSpriteNode] = []
    let box = SKSpriteNode(color: .black, size: CGSize(width: 10, height: 10))
    var boxArray: [SKSpriteNode] = []
    let blackboard = SKSpriteNode(imageNamed: "blackboard")
    var levelFinished : Bool = false
    var levelWrong : Bool = false
    var finalBox = SKSpriteNode(imageNamed: "3-quadro")
    var endText : SKLabelNode!
    var cont = 0
    
    override func didMove(to view: SKView) {
        
        setLevelName(name: .paper)
        setBackground(bgImg: SKSpriteNode(imageNamed: "bg2"))
        
        addLevelLabel()
        setButtons()
        addButtons()
        
        
//        bgimg.position = CGPoint(x: 0, y: 0) //posiciona a variável no centro da tela
//        self.addChild(bgimg) //adiciona a imagem ao node
//        bgimg.zPosition = -3 //método para colocar a imagem ao fundo, atrás dos demais elementos que forem colocados na tela
//        blackboard.position = CGPoint(x: 0, y: 250)
//        blackboard.setScale(0.22)
//        bgimg.addChild(blackboard)
        
        
        for i in 0...11{
            paper = SKSpriteNode(imageNamed: "\(i)")
            imageArray.append(paper!)
            imageArray[i] = SKSpriteNode(imageNamed: "\(i)")
            imageArray[i].name = String(i)
            imageArray[i].position = CGPoint(x: 0, y: -400) //posiciona o adesivo no centro, na parte de baixo da tela
            self.addChild(imageArray[i])
            self.physicsWorld.gravity = CGVector(dx: 0, dy: 0) //determina que a gravidade sobre o formato do papel será estática sobre o eixo x-y
            self.physicsWorld.contactDelegate = self
            
            //label com a mensagem que aparece colocada sobre o papel.
            text = SKLabelNode(text: String(i))
            text.setScale(1.8)
            text.fontColor = .white
            text.position = CGPoint(x: 0, y: 0)
            imageArray[i].addChild(text)
        }
        
        var alpha : Int = -300
        var beta : Int = 400
        for k in 0...11 {
            boxArray.append(box)
            boxArray[k] = SKSpriteNode(color: .init(white: 10, alpha: 0), size: CGSize(width: 300, height: 300))
  //          boxArray[k] = SKSpriteNode(color: .red, size: CGSize(width: 250, height: 250))
            boxArray[k].position = CGPoint(x: alpha, y: beta)
            boxArray[k].physicsBody?.isDynamic = false //determina que o objeto seja estático e, consequentemente, reduz o processamento do programa
            self.addChild(boxArray[k])
            boxArray[k].zPosition = -1

            text = SKLabelNode(text: String(k))
            text.setScale(1.2)
            text.fontColor = .white
            text.position = CGPoint(x: 0, y: 0)
            boxArray[k].addChild(text)
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
        //puxar, pelo touch, se há algum outro node sobre o node clicado.
        // observar se o usuário está clicando sobre o vazio, para não pretender movimentar o vazio
        let touch = touches.first
        let touchLocation = touch?.location(in: self)
        let nodes = self.nodes(at: touchLocation!)
        
        let selectednode = nodes.compactMap({nodeontop in
                                                nodeontop as? SKSpriteNode})
        if let firstnode = selectednode.first?.name {
                actual = Int(firstnode)
        }
              
    }
    
    // funcão para mover o papel sempre que o usuário clicar sobre um deles.
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        let touchLocation = touch?.location(in: self)
        if let i = actual{
            imageArray[i].position = touchLocation!
            
        }
    }
    
    // determina o encerramento da movimentação conforme o usuário deixar de tocar na tela
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // a posição atual passa a ser nil, para que o Node não seja movimentado para a próxima posição.
        actual = nil
        if (cont >= 11) {
            checkLevel()
        }
        cont += 1
    }

    //função de atualização, cuja atualização ocorre automaticamente
    func checkLevel () {
        checkNodes()
        if (levelFinished) {
            endLevel()
        }
//        if (levelWrong) {
//            returnInitialPosition()
//        }
    }
    
    
    func checkNodes() {
        let point2 = CGPoint(x: 0, y: -400)
        var nodeIntersect = Array(repeating: false, count: 12) //boolean array used to check if each node is movedto the right position
        var nodeMoved = Array(repeating: false, count: 12) //boolean array used to check if each node is moved, but it is in the wrong position
        for i in 0...11{
            if (!imageArray[i].position.equalTo(point2)){
                nodeMoved[i] = true
                if (boxArray[i].frame.contains(imageArray[i].frame)){
                    nodeIntersect[i] = true
                }
            }
        }
        
        if (nodeIntersect[0] == true && nodeIntersect[1] == true && nodeIntersect[2] == true && nodeIntersect[3] == true && nodeIntersect[4] == true && nodeIntersect[5] == true && nodeIntersect[6] == true && nodeIntersect[7] == true && nodeIntersect[8] == true && nodeIntersect[9] == true && nodeIntersect[10] == true && nodeIntersect[11] == true){
            levelFinished = true
        }
        
        // method to check if all paper nodes were moved to the wrong position.
        if (nodeMoved[0] == true && nodeMoved[1] == true && nodeMoved[2] == true && nodeMoved[3] == true && nodeMoved[4] == true && nodeMoved[5] == true && nodeMoved[6] == true && nodeMoved[7] == true && nodeMoved[8] == true && nodeMoved[9] == true && nodeMoved[10] == true && nodeMoved[11] == true){
            levelWrong = true
        }
    }
    
    
//    func returnInitialPosition () {
//        for i in 0...11{
//            imageArray[i].position = CGPoint(x: 0, y: -400)
//        }
//        GameScene.
//        let newScene = GameScene(size: self.size)
//    }
    
    
    func endLevel() {
        
        removeButtons()
        removeLevelLabel()
        
        for i in 0...11{
            imageArray[i].removeFromParent()
            boxArray[i].removeFromParent()
        }
        let endLabel = SKLabelNode()
        endLabel.fontSize = self.size.height/40
        endLabel.fontColor = .white
        endLabel.text = levelcomplete[levelName]
        endLabel.preferredMaxLayoutWidth = 700
        endLabel.numberOfLines = 0
        endLabel.position = CGPoint(x: 0, y: 0)
        endLabel.zPosition = 1
        self.addChild(endLabel)
        
//        endText = SKLabelNode(text: finalText)
//        endText.fontColor = .white
//        endText.fontSize = 70
//        endText.position = CGPoint(x: 0, y: -200)
//        endText.setScale(2)
//        endText.preferredMaxLayoutWidth = 900
//        endText.numberOfLines = 0
//        blackboard.addChild(endText)
        
    }
   
    
}
