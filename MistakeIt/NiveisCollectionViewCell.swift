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
        nivel.image = niveis.image
    }
}
