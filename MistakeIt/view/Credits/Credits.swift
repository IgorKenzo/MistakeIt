//
//  credit.swift
//  MistakeIt
//
//  Created by marcelo frost marchesan on 20/11/20.
//

import Foundation
import SpriteKit

class Credits: SKScene, CommonProperties, SceneManager {
    
    var levelName: LevelState!
    
    var settingsButton: GameButtonNode!
    
    var hintButton: GameButtonNode!
    
    var background: SKEffectNode!
    
    var levelLabel: SKLabelNode!
    
    var labelName : SKLabelNode!
    
    let gameName = "Mistake it!"
    
    var labelInfo1 : SKLabelNode!
    var labelInfo2 : SKLabelNode!
    var labelInfo3 : SKLabelNode!
    
    let infoText1 = """
                O presente software foi desenvolvido com a proposta de mostrar ao usuário, de uma forma leve e simples, como erros fazem parte do dia a dia, em especial de processos criativos, e como erros podem ser incorporados em nosso aprendizado.
                """
    
    let infoText2 = """
                Os exemplos foram escolhidos pois representam histórias de sucesso que surgiram a partir de erros cometidos pelos seus criadores e mostram que se deve refletir sobre o erro e verificar se ele apresenta um resultado positivo ou um aprendizado, ainda que não esperado dentro do processo criativo.
                """
    
    let infoText3 = """
                As informações apresentadas no presente software foram obtidas pelos desenvolvedores a partir de pesquisas realizadas e retratam eventos históricos de forma resumida e adaptada para a proposta do jogo.
                """
    
    var labelEquipe : SKLabelNode!
    
    let equipe = """
                Desenvolvedores:

                    Ellen de Brito Couto
                    Igor Kenzo Miyamoto Dias
                    Marcelo Frost Marchesan
                    Maria Luiza Sayuri Hioki
                """
    
    var labelFinalInfo : SKLabelNode!
    
    let finalInfo = """
                    Imagens e textos de propriedade exclusiva dos desenvolvedores.

                    Apple Developer Academy / SENAC/SP - 2020

                                    Obrigado por Jogar!
                    """
    var home : SKSpriteNode!
    
    override func didMove(to view: SKView) {
        //set the background using CommomProperties method
        setBackground(bgImg: SKSpriteNode(imageNamed: "bg"))
        
        //call the setting of each label node by the method compile
        labelName = compile(text: gameName, position: CGPoint(x: 0, y: 800))
        labelInfo1 = compile(text: infoText1, position: CGPoint(x: 0, y: 600))
        labelInfo2 = compile(text: infoText2, position: CGPoint(x: 0, y: 300))
        labelInfo3 = compile(text: infoText3, position: CGPoint(x: 0, y: 0))
        labelEquipe = compile(text: equipe, position: CGPoint(x: 0, y: -250))
        labelFinalInfo = compile(text: finalInfo, position: CGPoint(x: 0, y: -500))
        
        //call the method to add the home button
        addHomeButton()
    }
    
    //method to add the text to the label nodes and set the layout and position of the nodes
    func compile (text : String, position : CGPoint) -> SKLabelNode {
        let labelNode : SKLabelNode = SKLabelNode(text: text)
        labelNode.horizontalAlignmentMode = .center
        labelNode.verticalAlignmentMode = .center
        labelNode.fontName = "Abyss"
        labelNode.fontColor = .white
        labelNode.numberOfLines = 0
        labelNode.position = position
        labelNode.zPosition = 1
        labelNode.preferredMaxLayoutWidth = 700
        self.addChild(labelNode)
        return labelNode
    }

    //method that adds a home button on the botton of the screen, using the same method present in CommomProperties
    func addHomeButton () {
        home = GameButtonNode(image: SKTexture(imageNamed: "home"), onTap: {PlayViewController.BackToMenu()})
        home.position = CGPoint(x: 0 , y: -700)
        home.setScale(0.02)
        home.zPosition = 1
        self.addChild(home)
    }
    
}

