//
//  Niveis.swift
//  MistakeIt
//
//  Created by Sayuri Hioki on 16/11/20.
//

import UIKit

struct Niveis {
    var image: UIImage
    var name : LevelState
}

let nivel1 = Niveis(image: UIImage(named: "1.jpg")!, name: .lamp)
let nivel2 = Niveis(image: UIImage(named: "2.jpg")!, name: .peni)
let nivel3 = Niveis(image: UIImage(named: "3.png")!, name: .pace)
let nivel4 = Niveis(image: UIImage(named: "4.png")!, name: .postit)

func create() -> [Niveis]{
    return [nivel1, nivel2, nivel3, nivel4]
}
