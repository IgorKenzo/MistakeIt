//
//  GameScene.swift
//  ProjetoErro
//
//  Created by IgorMiyamoto on 14/10/20.
//

import SpriteKit
import GameplayKit


class PaperScene: SKScene, SKPhysicsContactDelegate {
    
    var bgimg: SKSpriteNode!
    var paper: SKSpriteNode!
    var text: SKLabelNode!
    var box: SKSpriteNode!
    var imageArray : [SKSpriteNode] = []
    var imageMovable = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        bgimg = SKSpriteNode(imageNamed: "img_prancheta") //atribui a imagem à variável de fundo
        bgimg.position = CGPoint(x: 0, y: 0) //posiciona a variável no centro da tela
        bgimg.setScale(0.209) //determina que a imagem terá uma escala 0.209 do tamanho original do arquivo
        self.addChild(bgimg) //adiciona a imagem ao node
        bgimg.zPosition = -3 //método para colocar a imagem ao fundo, atrás dos demais elementos que forem colocados na tela
        
        let paper = SKSpriteNode(imageNamed: "img_papel_adesivado")
       
        for i in 0...5{
            imageArray.append(paper)
            imageArray[i] = SKSpriteNode(imageNamed: "img_papel_adesivado")

            imageArray[i].position = CGPoint(x: 0, y: -400) //posiciona o adesivo no centro, na parte de baixo da tela
            imageArray[i].setScale(0.8) //determina que a imagem terá uma escala 0.8 do tamanho original do arquivo
            self.addChild(imageArray[i])
            self.physicsWorld.gravity = CGVector(dx: 0, dy: 0) //determina que a gravidade sobre o formato do papel será estática sobre o eixo x-y
            self.physicsWorld.contactDelegate = self
            
            //label com a mensagem que aparece colocada sobre o papel.
            let text : SKLabelNode = SKLabelNode(text: "Teste Teste Teste")
            text.fontColor = .black
            text.position = CGPoint(x: 0, y: 0)
            imageArray[i].addChild(text)
            
            }
    }
    
    // funcão para mover o papel sempre que o usuário clicar sobre um deles.
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        var i = 0
        for touch in touches {
            
            let location = touch.location(in: self)
            imageArray[i].position.x = location.x
            imageArray[i].position.y = location.y
            i+=1
            
        }
        
    }
    

}
