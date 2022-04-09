//
//  LaunchScreenViewController.swift
//  DrinkWater
//
//  Created by beneDev on 2022/04/04.
//

import UIKit

import Lottie
import SnapKit
import Then

final class LaunchScreenViewController: UIViewController {
    
    private let animationView = AnimationView(name: "cactus").then {
        $0.contentMode = .scaleAspectFit
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(animationView)
        animationView.center = view.center
        animationView.play { _ in
            self.animationView.removeFromSuperview()
            
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = windowScene.windows.first else {
                return
            }
            
            let duration: CGFloat = 0.5
            let options: UIView.AnimationOptions = .transitionCrossDissolve
            UIView.transition(with: window, duration: duration, options: options) {
                let vc = DrinkWaterViewController()
                let nav = UINavigationController(rootViewController: vc)
                window.rootViewController = nav
            }
        }
    }
}
