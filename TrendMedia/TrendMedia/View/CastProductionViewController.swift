//
//  CastProductionViewController.swift
//  TrendMedia
//
//  Created by beneDev on 2022/04/14.
//

import UIKit

class CastProductionViewController: UIViewController {

    private let mainView = CastProductionView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let title = "출연/제작"
        let font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        configureNavigation(title: title, titleColor: .black, titleFont: font)
        
//        navigationController?.navigationBar.topItem?.title = "뒤로"
    }
}
