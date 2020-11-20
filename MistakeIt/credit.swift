//
//  credit.swift
//  MistakeIt
//
//  Created by marcelo frost marchesan on 20/11/20.
//

import Foundation
import SpriteKit

class credit: SKScene, CommonProperties {
    
    var background: SKEffectNode!
    
    var labelName : SKLabelNode
    
    let gameName = "Mistake it!"
    
    var laelInfo : SKLabelNode
    
    let infoText1 = """
                O presente software foi desenvolvido com a proposta de mostrar ao usuário, de uma forma leve e simples, como erros fazem parte do dia a dia, em especial de processos criativos, e como erros podem ser incorporados em nosso aprendizado.
                """
    
    let infoText2 = """
                Os exemplos foram escolhidos pois representam histórias de sucesso que surgiram a partir de erros cometidos pelos seus criados, erros no processo de desenvolvimento de algum produto, ou porque mostram que se deve olhar para o erro e verificar se ele apresenta um resultado positivo, ainda que não esperado dentro do processo criativo.
                """
    
    let infoText3 = """
                As informações apresentadas no presente software foram obtidas pelos desenvolvedores a partir de pesquisas realizadas e retratam, de forma resumida, eventos históricos.
                """
    
    var labelEquipe : SKLabelNode
    
    let equipe = """
                Desenvolvedores:

                    Ellen de Brito Couto
                    Igor Kenzo Miyamoto Dias
                    Marcelo Frost Marchesan
                    Maria Luiza Sayuri Hioki
                """
    
    var labelFinalInfo : SKLabelNode
    
    let finalInfo = """
                    Imagens e textos de propriedade exclusiva dos desenvolvedores.

                    Apple Developer Academy / SENAC/SP
                    Nov de 2020
                    """
    
    override func didMove(to view: SKView) {
        
        setBackground(bgImg: SKSpriteNode(imageNamed: "bg2"))

        labelName = SKLabelNode(text: gameName)
        labelName.fontSize = self.size.height/70
        labelName.fontColor = .white
        labelName.preferredMaxLayoutWidth = 700
        labelName.numberOfLines = 0
        labelName.position = CGPoint(x: 0, y: 500)
        labelName.zPosition = 1
        background.addChild(labelName)
        
        laelInfo = SKLabelNode(text: infoText1)
        laelInfo.fontSize = self.size.height/40
        laelInfo.fontColor = .white
        laelInfo.preferredMaxLayoutWidth = 700
        laelInfo.numberOfLines = 0
        laelInfo.position = CGPoint(x: 0, y: 400)
        laelInfo.zPosition = 1
        background.addChild(laelInfo)

        laelInfo = SKLabelNode(text: infoText2)
        laelInfo.fontSize = self.size.height/40
        laelInfo.fontColor = .white
        laelInfo.preferredMaxLayoutWidth = 700
        laelInfo.numberOfLines = 0
        laelInfo.position = CGPoint(x: 0, y: 200)
        laelInfo.zPosition = 1
        background.addChild(laelInfo)
        
        laelInfo = SKLabelNode(text: infoText3)
        laelInfo.fontSize = self.size.height/40
        laelInfo.fontColor = .white
        laelInfo.preferredMaxLayoutWidth = 700
        laelInfo.numberOfLines = 0
        laelInfo.position = CGPoint(x: 0, y: 0)
        laelInfo.zPosition = 1
        background.addChild(laelInfo)
        
        labelEquipe = SKLabelNode(text: equipe)
        labelEquipe.fontSize = self.size.height/40
        labelEquipe.fontColor = .white
        labelEquipe.preferredMaxLayoutWidth = 700
        labelEquipe.numberOfLines = 0
        labelEquipe.position = CGPoint(x: 0, y: -200)
        labelEquipe.zPosition = 1
        background.addChild(labelEquipe)

        labelFinalInfo = SKLabelNode(text: finalInfo)
        labelFinalInfo.fontSize = self.size.height/40
        labelFinalInfo.fontColor = .white
        labelFinalInfo.preferredMaxLayoutWidth = 700
        labelFinalInfo.numberOfLines = 0
        labelFinalInfo.position = CGPoint(x: 0, y: -500)
        labelFinalInfo.zPosition = 1
        background.addChild(labelFinalInfo)
        
    }

    
}

