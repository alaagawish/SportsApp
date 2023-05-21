//
//  SplashViewController.swift
//  SportsApp
//
//  Created by Alaa on 19/05/2023.
//

import UIKit
import Lottie


class SplashViewController: UIViewController {
    let animationView = LottieAnimationView(name:"ball")
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startAnimation()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.performSegue(withIdentifier: "OpenHome", sender: nil)
        }
        
    }
    
    func startAnimation(){
        animationView.frame = view.bounds
        animationView.backgroundColor = .white
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        view.addSubview(animationView)
    }
    
    
    
}
