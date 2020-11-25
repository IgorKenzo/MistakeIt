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
                Os exemplos foram escolhidos pois representam histórias de sucesso que surgiram a partir de erros cometidos pelos seus criados, erros no processo de desenvolvimento de algum produto, ou porque mostram que se deve olhar para o erro e verificar se ele apresenta um resultado positivo, ainda que não esperado dentro do processo criativo.
                """
    
    let infoText3 = """
                As informações apresentadas no presente software foram obtidas pelos desenvolvedores a partir de pesquisas realizadas e retratam, de forma resumida, eventos históricos.
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

                    Apple Developer Academy / SENAC/SP
                    Nov de 2020
                    """
    
    override func didMove(to view: SKView) {
        
        setBackground(bgImg: SKSpriteNode(imageNamed: "bg"))
        
        labelName = compile(text: gameName, position: CGPoint(x: 0, y: 800))
        labelInfo1 = compile(text: infoText1, position: CGPoint(x: 0, y: 600))
        labelInfo2 = compile(text: infoText2, position: CGPoint(x: 0, y: 100))
        labelInfo3 = compile(text: infoText3, position: CGPoint(x: 0, y: 0))
        labelEquipe = compile(text: equipe, position: CGPoint(x: 0, y: -200))
        labelFinalInfo = compile(text: finalInfo, position: CGPoint(x: 0, y: -500))
        
        endLevel(fowardDestination: {self.loadScene(withIdentifier: .credits)})
    }
    
    
    func compile (text : String, position : CGPoint) -> SKLabelNode {
        let labelNode : SKLabelNode = SKLabelNode(text: text)
        labelNode.fontName = "Abyss"
        labelNode.fontColor = .white
        labelNode.numberOfLines = 0
        labelNode.position = position
        labelNode.zPosition = 1
        labelNode.preferredMaxLayoutWidth = 700
        self.addChild(labelNode)
        return labelNode
    }
    
    
    

    
    
    
    
    
    
    
    
}

