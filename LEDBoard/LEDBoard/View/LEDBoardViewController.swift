//
//  LEDBoardViewController.swift
//  LEDBoard
//
//  Created by beneDev on 2022/03/14.
//

import UIKit

final class LEDBoardViewController: UIViewController {

    private let mainView = LEDBoardView()
    private let viewModel = LEDBoardViewModel()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        mainView.changeColorButton.addTarget(self, action: #selector(changeColorButtonClicked), for: .touchUpInside)
    }

    @objc private func changeColorButtonClicked() {
        
        let color = UIColor.random
        mainView.changeColorButton.setTitleColor(color, for: .normal)
        mainView.boardLabel.textColor = color
    }
}

