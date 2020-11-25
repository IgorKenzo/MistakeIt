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

let nivel1 = Niveis(image: UIImage(named: "level1Icon")!, name: .lamp)
let nivel2 = Niveis(image: UIImage(named: "level2Icon")!, name: .peni)
let nivel3 = Niveis(image: UIImage(named: "level3Icon")!, name: .paper)
let nivel4 = Niveis(image: UIImage(named: "level4Icon")!, name: .pace)


func create() -> [Niveis]{
    return [nivel1, nivel2, nivel3, nivel4]
}
