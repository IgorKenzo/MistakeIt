//
//  Niveis.swift
//  MistakeIt
//
//  Created by Sayuri Hioki on 16/11/20.
//

import UIKit

struct Niveis {
    var image : UIImage
    var name : LevelState
}

let nivel1 = Niveis(image: UIImage(named: "blur.jpg")!, name: .lamp)
let nivel2 = Niveis(image: UIImage(named: "2-bg.jpg")!, name: .peni)
let nivel3 = Niveis(image: UIImage(named: "4.png")!, name: .paper)
let nivel4 = Niveis(image: UIImage(named: "corasson.png")!, name: .pace)


func create() -> [Niveis]{
    return [nivel1, nivel2, nivel3, nivel4]
}
