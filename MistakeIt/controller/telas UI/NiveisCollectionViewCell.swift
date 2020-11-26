//
//  NiveisCollectionViewCell.swift
//  MistakeIt
//
//  Created by Sayuri Hioki on 06/11/20.
//

import UIKit

class NiveisCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nivel: UIImageView!
    private let blockedImg = UIImage(named: "lvlblck")
    
    func configure(with niveis: Niveis, unlocked: Bool?){
        nivel.layer.cornerRadius = nivel.frame.size.height / 2
        nivel.clipsToBounds = true
        if let val = unlocked {
            if val {
                nivel.image = niveis.image
            } else {
                nivel.image = blockedImg
            }
        }
        
    }
}
