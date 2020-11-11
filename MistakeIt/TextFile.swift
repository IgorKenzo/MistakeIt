//
//  HintsFile.swift
//  MistakeIt
//
//  Created by marcelo frost marchesan on 27/10/20.
//

import Foundation

let leveltexts : [LevelState:String] = [.lamp: "O erro é um aprendizado e não apenas um erro!",
                                        .postit: "Ser descolado pode ser bom também!",
                                        .peni: "O erro pode mover as coisas para o lugar certo!",
                                        .doceleite: "Errar pode ser delicioso!",
                                        .marc: "As vezes precisamos errar passo a passo!"]


let hints : [LevelState:String] = [.lamp: "Ajeite o filamento da lâmpada.",
                                   .postit: "Cole o papel no lugar correto!",
                                   .peni: "Arraste algo pela tela.",
                                   .doceleite: "Já pensou em esperar a comida por mais tempo?",
                                   .marc: "As vezes menos é mais!"]

let instruction = "Olá! Neste jogo os puzzles não possuem instruções. O objetivo é descobrir qual sua solução através da tentativa e erro. Não se preocupe e não tenha medo de errar, você logo pegará o jeito!"


let levelcomplete : [LevelState:String] = [.lamp:"Thomas Edison em 1879 mencionou que foram necessários mais de 100 testes diferentes antes de se chegar ao modelo final. 'Eu aprendi muito mais com os meus erros do que com meus acertos.'",
                                           .postit: "O inventor do primeiro papel auto-colante, Spencer Silver, procurava criar uma cola super aderente, mas conseguiu apenas uma cola de pouca aderência. Seu parceiro de trabalho, Arthur Fry, observou que a cola permitia aderir folhas de papel sem rasgá-las no momento de descolar. Juntos, a partir do erro inicial, inventaram um papel adesivado que pode ser colocado e descolado diversas vezes, transformando-se em um verdadeiro sucesso comercial.",
                                           .peni: "Pesquisando como combater bactérias em ferimentos, o médico Alexander Fleming cometeu um erro em suas pesquisas em virtude de seu cansaço. Ele esqueceu o material pesquisado aberto e fora de conservação, o que fez com que fungos aparecessem no material de pesquisa. Posteriormente, percebeu que onde o fungo havia se espalhado, as bactérias não se reproduziam. Anos mais tarde, a descoberta de Fleming permitiu a outros cientistas desenvolverem uma forma de combater as bactérias a partir do material coletado de fungos, levando à invenção da penicilina.",
                                           .doceleite: " Em 1829 uma cozinheira preparava um doce de leite com açúcar para servir a convidados de uma festa. Ao se distrair, a cozinheira deixou os ingredientes no fogo por mais tempo do que a receita exigia, criando uma mistura mais escura e espessa. Sem tempo de corrigir o erro, a mistura foi servida aos convidados, provando-se um verdadeiro sucesso. Foi inventado, assim, o doce de leite na Argentina.",
                                           .marc: "O marca passo foi inventado por Wilson Greatbatch em 1956. Inicialmente o pesquisador estava construindo um dispositivo para medir os movimentos cardíacos. Ao trabalhar em seu dispositivo, porém, removeu acidentalmente um dos fios do aparelho, o que fez com que o aparelho emitisse sinais elétricos em um ritmo semelhante às batidas do coração humano. Isso permitiu criar um aparelho para induzir o coração aos batimentos corretos a partir dos sinais elétricos."]



//"Foram diversas as tentativas de criar a lâmpada incandescente até que Thomas Alva Edison conseguiu chegar em modelo durável e comercializável em 1879. O próprio inventor mencionou que foram necessários mais de 100 testes diferentes antes de se chegar ao modelo final. Uma das frases atribuídas ao inventor é ''Eu aprendi muito mais com os meus erros do que com meus acertos.'', provando que devemos valorizar os resultados de nossos erros.",

