//
//  ProfileViewController.swift
//  DrinkWater
//
//  Created by beneDev on 2022/04/04.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    private let mainView = ProfileView()
    
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    private func configureNavigationBar() {
        
        navigationItem.title = ""
        
        navigationItem.backBarButtonItem?.title = "물 마시기"
        let rightItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
        navigationItem.rightBarButtonItems = [rightItem]
//        rightItem.tintColor = .white
        
        navigationController?.navigationBar.tintColor = .white
    }
    
    @objc private func saveButtonClicked() {
        print(#function)
        
    }
}
