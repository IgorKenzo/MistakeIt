//
//  Niveis.swift
//  MistakeIt
//
//  Created by Sayuri Hioki on 16/11/20.
//

import SwiftUI

struct Niveis {
    var image: UIImage
}

let nivel1 = Niveis(image: UIImage(named: "1.jpg")!)
let nivel2 = Niveis(image: UIImage(named: "2.jpg")!)
let nivel3 = Niveis(image: UIImage(named: "3.png")!)
let nivel4 = Niveis(image: UIImage(named: "4.png")!)

func create() -> [Niveis]{
    return [nivel1, nivel2, nivel3, nivel4]
}
