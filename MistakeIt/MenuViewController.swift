//
//  GameViewController.swift
//  MistakeIt
//
//  Created by IgorMiyamoto on 09/11/20.
//

import SpriteKit
import AVFoundation
var AudioPlayer = AVAudioPlayer()

class MenuViewController: UIViewController {
    
    var levelToPlay : LevelState?
    var tocando = true
    
    @IBOutlet weak var musicBtn: UIButton!
    
    @IBAction func musicaBtn(_ sender: UIButton) {
        musicaTocando()
    }
    
    @IBAction func niveisBtn(_ sender: Any) {
        AudioPlayer.stop()
    }
    
    @IBAction func helpBtn(_ sender: Any) {
        animateIn(x: blurView)
        animateIn(x: popUpView)
    }
    
    @IBAction func okBtn(_ sender: Any) {
        animateOut(x: popUpView)
        animateOut(x: blurView)
        UIDevice.vibrate()
    }
    
    @IBAction func unwindToMenu(_ unwindSegue: UIStoryboardSegue) {
        //let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }
    
    @IBAction func playButton(_ sender: Any) {
        updadeLevelPlayed()
        performSegue(withIdentifier: "actionPlay", sender: nil)
        AudioPlayer.stop()
    }
    @IBOutlet var blurView: UIVisualEffectView!
    @IBOutlet var popUpView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //configuração do som de fundo
        AVAudioPlayer.play()
        //tamanho da blurView
        blurView.bounds = self.view.bounds
        //tamanho do popUp
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
    //função para criar animação quando o popUp aparecer
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
    
    //função para desaparecer o popUp
    func animateOut(x: UIView){
        
        UIView.animate(withDuration: 0.4, animations: {
            x.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            x.alpha = 0
        }, completion: { _ in
            x.removeFromSuperview()
        })
    }
    
    func musicaTocando(){
        if(tocando){
            AudioPlayer.stop()
            tocando = false
            musicBtn.setImage(UIImage(named:"sem-musica.png"), for: .normal)
        }else{
            AudioPlayer.play()
            tocando = true
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
            AudioPlayer.stop()
        }
    }
}
extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}
extension AVAudioPlayer{
    static func play(){
        let AssortedMusics = NSURL(fileURLWithPath: Bundle.main.path(forResource: "teste", ofType: "mp3")!)
        AudioPlayer = try! AVAudioPlayer(contentsOf: AssortedMusics as URL)
        AudioPlayer.prepareToPlay()
        AudioPlayer.numberOfLoops = -1
        AudioPlayer.play()
    }
}
