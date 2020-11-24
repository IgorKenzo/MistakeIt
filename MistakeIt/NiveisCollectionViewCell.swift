//
//  NiveisCollectionViewCell.swift
//  MistakeIt
//
//  Created by Sayuri Hioki on 06/11/20.
//

import UIKit

class NiveisCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nivel: UIImageView!
    
    func configure(with niveis: Niveis){
        nivel.layer.cornerRadius = nivel.frame.size.height / 2
        nivel.clipsToBounds = true
        nivel.image = niveis.image
    }
}
