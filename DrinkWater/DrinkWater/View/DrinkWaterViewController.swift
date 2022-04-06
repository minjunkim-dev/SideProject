//
//  DrinkWaterViewController.swift
//  DrinkWater
//
//  Created by beneDev on 2022/04/04.
//

import UIKit
import Lottie

final class DrinkWaterViewController: UIViewController {
    
    private let mainView = DrinkWaterView()
    
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        
        mainView.inputIntakeTextField.delegate = self
        mainView.inputIntakeTextField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        
        mainView.addIntakeButton.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadView()
    }
    
    private func reloadView() {
        let height = UserDefaults.height
        let weight = UserDefaults.weight
        guard height != 0, weight != 0 else {
            print("프로필 입력 필요")
            return
        }
        
        let recommendedIntake = Int(Double(height + weight) / 100 * 1000) // ml
        let targetPercentage = round((Double(UserDefaults.todayIntake) / Double(recommendedIntake)) * 100) // %
        
        var targetPercentageColor: UIColor
        if targetPercentage >= 100 {
            targetPercentageColor = .red
        } else if targetPercentage >= 50 {
            targetPercentageColor = .blue
        } else {
            targetPercentageColor = .white
        }
        
        let attributedText = NSMutableAttributedString()
            .attributedText(target: "잘하셨어요!\n오늘 마신 양은\n", font: .systemFont(ofSize: 22, weight: .medium), color: .white)
            .attributedText(target: "\(UserDefaults.todayIntake)ml\n", font: .systemFont(ofSize: 33, weight: .heavy), color: .white)
            .attributedText(target: "목표의 \(Int(targetPercentage))%", font: .systemFont(ofSize: 15, weight: .regular), color: targetPercentageColor)
   
        mainView.todayIntakeLabel.attributedText = attributedText
    
        let digit: Double = pow(10, 2)
        mainView.recommendedIntakeLabel.text = "\(UserDefaults.nickname)님의 하루 물 권장 섭취량은 \(round(Double(recommendedIntake) / 1000 * digit) / digit)L 입니다."
        
        var image: UIImage
        if targetPercentage > 100.0 {
            image = Assets.phase9.image
        } else if targetPercentage > 87.5 {
            image = Assets.phase8.image
        } else if targetPercentage > 75.0 {
            image = Assets.phase7.image
        } else if targetPercentage > 62.5 {
            image = Assets.phase6.image
        } else if targetPercentage > 50.0 {
            image = Assets.phase5.image
        } else if targetPercentage > 37.5 {
            image = Assets.phase4.image
        } else if targetPercentage > 25.0 {
            image = Assets.phase3.image
        } else if targetPercentage > 12.5 {
            image = Assets.phase2.image
        } else { // 0 ~ 12.5%
            image = Assets.phase1.image
        }
        
        UIView.transition(with: mainView.imageView,
                          duration: 0.75,
                          options: .transitionCrossDissolve) {
            self.mainView.imageView.image = image
        }
    }
    
    @objc private func addButtonClicked() {
        
        guard let text = mainView.inputIntakeTextField.text, text.contains("ml"),
              let intake = Int(text.replacingOccurrences(of: "ml", with: "")) else {
            print("마신 양 입력 필요")
            return
        }
        
        UserDefaults.todayIntake += intake
        UserDefaults.todayLastIntake.append(intake)
        
        reloadView()
    }
    
    @objc private func textFieldEditingChanged() {
        
        let maxLength = UserInfoValidation.intake.range.upperBound
          
        guard let text = mainView.inputIntakeTextField.text, text.count <= maxLength else {
            mainView.inputIntakeTextField.deleteBackward()
            return
        }
        
        mainView.inputIntakeTextField.text = text
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 18, weight: .heavy)]
        navigationItem.title = "물 마시기"
        
        let leftItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(revertButtonClicked))
        let rightItem = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: self, action: #selector(profileButtonClicked))
        navigationItem.leftBarButtonItems = [leftItem]
        navigationItem.rightBarButtonItems = [rightItem]
//        leftItem.tintColor = .white
//        rightItem.tintColor = .white
        navigationController?.navigationBar.tintColor = .white
    }
    
    @objc private func revertButtonClicked() {
        
        if let _ = navigationItem.leftBarButtonItems?.first {
            
            print("정말 최근에 입력한 물의 양을 되돌릴지 여부를 다시 확인 필요")
            
            guard UserDefaults.todayLastIntake.last != nil else {
                print("오늘 더이상 되돌릴 물의 양이 없음")
                return
            }
            
            UserDefaults.todayIntake -= UserDefaults.todayLastIntake.removeLast()
            
            reloadView()
        }
    }
    
    @objc private func profileButtonClicked() {
        
        if let _ = navigationItem.rightBarButtonItems?.first {
            let vc = ProfileViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension DrinkWaterViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        guard let text = textField.text, text.contains("ml") else {
            return
        }
        
        textField.text = text.replacingOccurrences(of: "ml", with: "")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let text = textField.text {
            
            let regex = UserInfoValidation.intake.regex
            
            if text.validate(regex: regex) {
                print("유효함")
                mainView.inputIntakeTextField.text = "\(text)ml"
            } else {
                print("유효하지 않음")
                mainView.inputIntakeTextField.text = ""
            }
        
        } else {
            print("nil 값임")
        }
    }
}
