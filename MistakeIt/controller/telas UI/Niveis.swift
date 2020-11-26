//
//  Niveis.swift
//  MistakeIt
//
//  Created by Sayuri Hioki on 16/11/20.
//

import UIKit

//struct with the levels view elements
struct Niveis {
    var image : UIImage
    var name : LevelState
}

//declaration of each level
let nivel1 = Niveis(image: UIImage(named: "blur.jpg")!, name: .lamp)
let nivel2 = Niveis(image: UIImage(named: "2-bg.jpg")!, name: .peni)
let nivel3 = Niveis(image: UIImage(named: "4.png")!, name: .paper)
let nivel4 = Niveis(image: UIImage(named: "corasson.png")!, name: .pace)

//function to send the levels to the view
func create() -> [Niveis]{
    return [nivel1, nivel2, nivel3, nivel4]
}
