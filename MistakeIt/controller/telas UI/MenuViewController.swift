//
//  GameViewController.swift
//  MistakeIt
//
//  Created by IgorMiyamoto on 09/11/20.
//

import SpriteKit
import AVFoundation

//dictionary with all audios used in the project
var audios: [String: AVAudioPlayer] = ["teste": AVAudioPlayer(), "lightning": AVAudioPlayer()]

class MenuViewController: UIViewController {
    
    //variables declaration
    var levelToPlay : LevelState?
    var tocando = true
    
    //button to stop and play the home's background music
    @IBOutlet weak var musicBtn: UIButton!
    @IBAction func musicaBtn(_ sender: UIButton) {
        musicaTocando()
    }
    
    //when the levels button is clicked the background sound stops
    @IBAction func niveisBtn(_ sender: Any) {
        audios["teste"]!.stop()
    }
    
    //shows a view with a basic explanation of the game
    @IBAction func helpBtn(_ sender: Any) {
        animateIn(x: blurView)
        animateIn(x: popUpView)
    }
    
    //goes back from the explanation view to the home view
    @IBAction func okBtn(_ sender: Any) {
        animateOut(x: popUpView)
        animateOut(x: blurView)
    }
    
    @IBAction func unwindToMenu(_ unwindSegue: UIStoryboardSegue) {
        //let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }
    
    //goes straight to the next level to be played
    @IBAction func playButton(_ sender: Any) {
        updadeLevelPlayed()
        performSegue(withIdentifier: "actionPlay", sender: nil)
        //stops the background sound
        audios["teste"]!.stop()
    }
    
    @IBOutlet var blurView: UIVisualEffectView!
    @IBOutlet var popUpView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //initializing function that brings all the sounds of the game
        importAudio()
        //background sound setting
        audios["teste"]!.play()
        //blurView size
        blurView.bounds = self.view.bounds
        //popUpView size
        popUpView.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 450)
        
        updadeLevelPlayed()
    }
    
    func updadeLevelPlayed(){
        let levelrawvalue = UserDefaultManager.shared.getLastLevelPlayed()
        if let level = levelrawvalue {
            if level < 1 {
                levelToPlay = LevelState(rawValue: level+1)
            } else {
                levelToPlay = LevelState(rawValue: 0)
            }
        } else {
            levelToPlay = LevelState(rawValue: 0)
        }
    }
    
    //function to import all the sounds used in the game
    func importAudio(){
        for i in 0...audios.count-1{
            let chave = Array(audios)[i].key
            let AssortedMusics = NSURL(fileURLWithPath: Bundle.main.path(forResource: chave, ofType: "mp3")!)
            audios[chave] = try! AVAudioPlayer(contentsOf: AssortedMusics as URL)
            if(chave == "lightning"){
                audios[chave]!.numberOfLoops = -1
            }
        }
    }
    
    //function to create the animation when the popUp appears
    func animateIn(x: UIView){
        let backgroundView = self.view!
        
        backgroundView.addSubview(x)
        
        x.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        x.alpha = 0
        if(x == blurView){
        x.center = backgroundView.center
        } else{
            x.center = CGPoint(x: 207, y: 220)
        }
        
        UIView.animate(withDuration: 0.4, animations: {
            x.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            x.alpha = 1
        })
    }
    
    //function to create the animation when the popUp disappears
    func animateOut(x: UIView){
        UIView.animate(withDuration: 0.4, animations: {
            x.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            x.alpha = 0
        }, completion: { _ in
            x.removeFromSuperview()
        })
    }
    
    //implementation of the music function on the screen
    func musicaTocando(){
        if(tocando){
            //if the boolean "tocando" is true then the audio is stopped
            audios["teste"]!.stop()
            //the variable changes to false
            tocando = false
            //and the sound icon changes to a different one
            musicBtn.setImage(UIImage(named:"sem-musica.png"), for: .normal)
        }else{
            //if the boolean "tocando" is false then the audio is played
            audios["teste"]!.play()
            //the variable changes to true
            tocando = true
            //and the sound icon changes to the original one
            musicBtn.setImage(UIImage(named:"musica.png"), for: .normal)
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? PlayViewController {
            vc.LevelName = self.levelToPlay
            audios["teste"]!.stop()
        }
    }
}

