//
//  NiveisViewController.swift
//  MistakeIt
//
//  Created by Sayuri Hioki on 06/11/20.
//

import UIKit

class NiveisViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var bglevels: UIImageView!
//    @IBOutlet weak var bgImg: UIImageView!
    @IBOutlet weak var niveisCV: UICollectionView!
    //@IBOutlet weak var scrollView: UIScrollView!
    
    let cellIdentifier = "NivelCell"
    
    var data: [Niveis] = []
    
    private var levelname : LevelState? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: bgImg.bottomAnchor).isActive = true
        niveisCV.delegate = self
        niveisCV.dataSource = self
        
        data = create()
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if let Cell = collectionView.dequeueReusableCell(withReuseIdentifier:cellIdentifier, for: indexPath) as? NiveisCollectionViewCell{
            Cell.configure(with: data[indexPath.item])
            
            cell = Cell
         }
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        //print(data[indexPath.item])
        self.levelname = data[indexPath.item].name
        performSegue(withIdentifier: "callPlay", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PlayViewController {
            vc.LevelName = self.levelname
        }
    }
}


