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
    private let viewModel = DrinkWaterViewModel()
    
    private let validator = UserInfoValidator.shared
    
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
    
    private func getImageAccordingToAchivementRate() -> UIImage {
        
        if viewModel.achivementRate > 100.0 {
            return Assets.phase9.image
        } else if viewModel.achivementRate > 87.5 {
            return Assets.phase8.image
        } else if viewModel.achivementRate > 75.0 {
            return Assets.phase7.image
        } else if viewModel.achivementRate > 62.5 {
            return Assets.phase6.image
        } else if viewModel.achivementRate > 50.0 {
            return Assets.phase5.image
        } else if viewModel.achivementRate > 37.5 {
            return Assets.phase4.image
        } else if viewModel.achivementRate > 25.0 {
            return Assets.phase3.image
        } else if viewModel.achivementRate > 12.5 {
            return Assets.phase2.image
        } else { // 0 ~ 12.5%
            return Assets.phase1.image
        }
    }
    
    private func getColorAccordingToAchivementRate() -> UIColor {
        
        if viewModel.achivementRate >= 100 {
            return .red
        } else if viewModel.achivementRate >= 50 {
            return .blue
        } else {
            return .white
        }
    }
    
    private func reloadView() {
        
        viewModel.getRecommendedIntake()
        viewModel.getAchivementRate()
        
        let achivementRateColor = getColorAccordingToAchivementRate()
    
        let attributedText = NSMutableAttributedString()
            .attributedText(target: "잘하셨어요!\n오늘 마신 양은\n", font: .systemFont(ofSize: 22, weight: .medium), color: .white)
            .attributedText(target: "\(viewModel.todayIntake)ml\n", font: .systemFont(ofSize: 33, weight: .heavy), color: .white)
            .attributedText(target: "목표의 \(Int(viewModel.achivementRate))%", font: .systemFont(ofSize: 15, weight: .regular), color: achivementRateColor)
   
        mainView.todayIntakeLabel.transition(0.5, .fade, .none)
        mainView.todayIntakeLabel.attributedText = attributedText

        let image = getImageAccordingToAchivementRate()
        UIView.transition(with: mainView.imageView,
                          duration: 0.5,
                          options: .transitionCrossDissolve) {
            self.mainView.imageView.image = image
        }
        
        mainView.recommendedIntakeLabel.text = viewModel.recommendedIntake == 0 ? "프로필 입력이 필요합니다." : "\(viewModel.nickname)님의 하루 물 권장 섭취량은 \(viewModel.recommendedIntake.round(notation: 10, digit: 2) / 1000)L 입니다."
    }
    
    @objc private func addButtonClicked() {
        
        guard viewModel.recommendedIntake != 0 else {
            let message = "프로필을 먼저 입력하셔야 해요⚠️"
            let okTitle = "확인"
            showAlert(message: message, okTitle: okTitle, okCompletion: {
                let vc = ProfileViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            })
            return
        }
        
        guard let text = mainView.inputIntakeTextField.text, text.contains("ml"),
              let intake = Int(text.replacingOccurrences(of: "ml", with: "")) else {
        
            let message = "마신 물의 양을 입력해주세요😭"
            let okTitle = "확인"
            showAlert(message: message, okTitle: okTitle)
            return
        }
        
        viewModel.addTodayIntake(intake: intake)
        viewModel.todayLastIntake.append(intake)
        mainView.inputIntakeTextField.text = ""
        
        reloadView()
    }
    
    @objc private func textFieldEditingChanged() {
        
        let maxLength = validator.range(info: .intake).upperBound
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
            
            let title = "최근에 마신 물의 양을 되돌릴까요?"
            let okTitle = "확인"
            let cancleTitle = "취소"
            showActionSheet(title: title, okTitle: okTitle, okCompletion: {
                
                guard UserDefaults.todayLastIntake.last != nil else {
                    let message = "오늘은 더이상 되돌릴\n물의 양이 없어요 :("
                    let okTitle = "확인"
                    self.showAlert(message: message, okTitle: okTitle)
                    return
                }
                
                let intake = self.viewModel.removeLastTodayLastIntake()
                self.viewModel.subTodayIntake(intake: intake)
                self.reloadView()
                
            }, cancleTitle: cancleTitle) {
                return
            }
        }
    }
    
    @objc private func profileButtonClicked() {
        
        if let _ = navigationItem.rightBarButtonItems?.first {
            let vc = ProfileViewController()
            vc.image = mainView.imageView.image
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
            
            let regex = validator.regex(info: .intake)
            
            if validator.validate(target: text, regex: regex) {
                mainView.inputIntakeTextField.text = "\(text)ml"
            } else {
                mainView.inputIntakeTextField.text = ""
            }
        }
    }
}
