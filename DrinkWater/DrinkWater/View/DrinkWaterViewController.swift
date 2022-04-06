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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let height = UserDefaults.height
        let weight = UserDefaults.weight
        guard height != 0, weight != 0 else { return }
        
        let recommendedIntake = Int(Double(height + weight) / 100 * 1000) // ml
        let targetPercentage = Int(round((Double(UserDefaults.todayIntake) / Double(recommendedIntake)) * 100)) // %
        
        let attributedText = NSMutableAttributedString()
            .attributedText(target: "잘하셨어요!\n오늘 마신 양은\n", font: .systemFont(ofSize: 22, weight: .medium), color: .white)
            .attributedText(target: "\(UserDefaults.todayIntake)ml\n", font: .systemFont(ofSize: 33, weight: .heavy), color: .white)
            .attributedText(target: "목표의 \(targetPercentage)%", font: .systemFont(ofSize: 15, weight: .regular), color: .white)
   
        mainView.todayIntakeLabel.attributedText = attributedText
    
        let digit: Double = pow(10, 2)
        mainView.recommendedIntakeLabel.text = "\(UserDefaults.nickname)님의 하루 물 권장 섭취량은 \(round(Double(recommendedIntake) / 1000 * digit) / digit)L 입니다."
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
