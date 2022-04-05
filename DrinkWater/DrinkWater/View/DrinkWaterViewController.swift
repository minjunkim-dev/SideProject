//
//  DrinkWaterViewController.swift
//  DrinkWater
//
//  Created by beneDev on 2022/04/04.
//

import UIKit

final class DrinkWaterViewController: UIViewController {
    
    private let mainView = DrinkWaterView()
    
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let height = UserDefaults.height
        let weight = UserDefaults.weight
        guard height != 0, weight != 0 else { return }
        
        let recommendedIntake = Int(Double(height + weight) / 100 * 1000) // ml
        let targetPercentage = Int(round((Double(UserDefaults.todayIntake) / Double(recommendedIntake)) * 100)) // %
        
        mainView.todayIntakeLabel.text = """
        잘하셨어요!
        오늘 마신 양은
        \(UserDefaults.todayIntake)ml
        목표의 \(targetPercentage)%
        """
        
        let digit: Double = pow(10, 2)
        mainView.recommendedIntakeLabel.text = "\(UserDefaults.nickname)님의 하루 물 권장 섭취량은 \(round(Double(recommendedIntake) / 1000 * digit) / digit)L 입니다."
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 18, weight: .heavy)]
        navigationItem.title = "물 마시기"
        
        let leftItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: nil)
        let rightItem = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: self, action: #selector(profileButtonClicked))
        navigationItem.leftBarButtonItems = [leftItem]
        navigationItem.rightBarButtonItems = [rightItem]
//        leftItem.tintColor = .white
//        rightItem.tintColor = .white
        navigationController?.navigationBar.tintColor = .white
    }
    
    @objc func profileButtonClicked() {
        
        if let _ = navigationItem.rightBarButtonItems?.first {
            let vc = ProfileViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
