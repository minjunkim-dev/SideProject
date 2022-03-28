//
//  AnniversaryCalculatorViewController.swift
//  AnniversaryCalculator
//
//  Created by beneDev on 2022/03/27.
//

import UIKit

final class AnniversaryCalculatorViewController: UIViewController {
    
    private let mainView = AnniversaryView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
