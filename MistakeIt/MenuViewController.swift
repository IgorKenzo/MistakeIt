//
//  GameViewController.swift
//  MistakeIt
//
//  Created by IgorMiyamoto on 09/11/20.
//

import SpriteKit

class MenuViewController: UIViewController {

    @IBAction func helpBtn(_ sender: Any) {
        animateIn(x: blurView)
        animateIn(x: popUpView)
    }
    
    @IBAction func okBtn(_ sender: Any) {
        animateOut(x: popUpView)
        animateOut(x: blurView)
    }
    
    @IBAction func unwindToMenu(_ unwindSegue: UIStoryboardSegue) {
        //let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }
    
    @IBOutlet var blurView: UIVisualEffectView!
    @IBOutlet var popUpView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tamanho da blurView
        blurView.bounds = self.view.bounds
        //tamanho do popUp
        popUpView.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 450)
        
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
}
