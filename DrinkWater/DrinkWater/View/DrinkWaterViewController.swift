//
//  DrinkWaterViewController.swift
//  DrinkWater
//
//  Created by beneDev on 2022/04/04.
//

import UIKit

import SnapKit
import Then

final class DrinkWaterViewController: UIViewController {
    
    private let mainView = DrinkWaterView()
    
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
