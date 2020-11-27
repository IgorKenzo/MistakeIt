//
//  SplashScreen.swift
//  MistakeIt
//
//  Created by IgorMiyamoto on 27/11/20.
//

import UIKit

class SplashScreen: UIViewController {
    override func viewDidLoad() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        let splashGif = UIImage.gifImageWithName("splashgif")
        let imageView = UIImageView(image: splashGif)
        imageView.frame = self.view.frame
        view.addSubview(imageView)
        
        Timer.scheduledTimer(withTimeInterval: 5, repeats: false){ timer in
            timer.invalidate()
            self.performSegue(withIdentifier: "goMenu", sender: nil)
        }
    }
    
}
