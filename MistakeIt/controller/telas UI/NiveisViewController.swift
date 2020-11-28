//
//  NiveisViewController.swift
//  MistakeIt
//
//  Created by Sayuri Hioki on 06/11/20.
//

import UIKit
import AVFoundation
class NiveisViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var bglevels: UIImageView!
//    @IBOutlet weak var bgImg: UIImageView!
    @IBOutlet weak var niveisCV: UICollectionView!
    
    //the back button that goes back to the home view
    @IBAction func voltarBtn(_ sender: Any) {
        //the home view's background sound starts to play again
        audios["background"]?.play()
    }
    
    let cellIdentifier = "NivelCell"
    
    //array with all the levels
    var data: [Niveis] = []
    
    private var levelname : LevelState? = nil
    
    private var levelStatus : [Bool]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        niveisCV.delegate = self
        niveisCV.dataSource = self
        
        data = create()
        
        levelStatus = UserDefaultManager.shared.getUnlockedLevels()
    }

    //function that counts the number os items to create the same number os cells
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    //function to place the level image in the cell
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if let Cell = collectionView.dequeueReusableCell(withReuseIdentifier:cellIdentifier, for: indexPath) as? NiveisCollectionViewCell{
            Cell.configure(with: data[indexPath.item], unlocked: levelStatus?[indexPath.item])
            
            cell = Cell
         }
        return cell
    }
    
    //function to detect wich cell was clicked
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        //print(data[indexPath.item])
        if levelStatus![indexPath.item] {
            self.levelname = data[indexPath.item].name
            performSegue(withIdentifier: "callPlay", sender: nil)
        }
        
    }
    
    //function responsible for sending the level settings to the game screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PlayViewController {
            vc.LevelName = self.levelname
        }
    }
    override var prefersStatusBarHidden: Bool {
           return true
       }
}


