//
//  ProfileViewController.swift
//  DrinkWater
//
//  Created by beneDev on 2022/04/04.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    private let mainView = ProfileView()
    
    
    var image: UIImage?
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.profileImageView.image = image
        
        configureNavigationBar()
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
        
        var isValid = true
        for subView in mainView.profileStackView.arrangedSubviews {
            if let profileInputView = subView as? ProfileInputView {
                let info = profileInputView.info
                
                if !(profileInputView.validateText()) {
                    isValid = false
                    
                    let okTitle = "확인"
                    switch info {
                    case .nickname:
                        let message = "닉네임을 확인해주세요🚨"
                        showAlert(message: message, okTitle: okTitle)
                        return
                    case .height:
                        let message = "키를 확인해주세요🚨"
                        showAlert(message: message, okTitle: okTitle)
                        return
                    case .weight:
                        let message = "몸무게를 확인해주세요🚨"
                        showAlert(message: message, okTitle: okTitle)
                        return
                    case .intake:
                        break
                    }
                }
            }
        }
        
        if isValid {
            saveUserInfo()
        }
    }
    
    func saveUserInfo() {
        
        for subView in mainView.profileStackView.arrangedSubviews {
            if let profileInputView = subView as? ProfileInputView {
                profileInputView.saveUserInfo()
            }
        }
        
        let message = "프로필 정보가 저장되었어요 :)"
        let okTitle = "확인"
        showAlert(message: message, okTitle: okTitle, okCompletion: {
            self.navigationController?.popViewController(animated: true)
        })
    }
}
