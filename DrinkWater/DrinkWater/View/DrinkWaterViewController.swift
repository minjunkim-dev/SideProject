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
        print(#function)
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 18, weight: .heavy)]
        navigationItem.title = "물 마시기"
        
        let leftItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: nil)
        leftItem.tintColor = .white
        navigationItem.leftBarButtonItems = [leftItem]
        
        let rightItem = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .done, target: self, action: nil)
        rightItem.tintColor = .white
        navigationItem.rightBarButtonItems = [rightItem]
    }
}
