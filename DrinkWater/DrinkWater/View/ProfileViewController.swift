//
//  ProfileViewController.swift
//  DrinkWater
//
//  Created by beneDev on 2022/04/04.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    private let mainView = ProfileView()
    
    private let userNotificationCenter = UNUserNotificationCenter.current()
    
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
    
    private func saveUserInfo() {
        
        for subView in mainView.profileStackView.arrangedSubviews {
            if let profileInputView = subView as? ProfileInputView {
                profileInputView.sendNotiToSaveInfo()
            }
        }
        
        let message = "프로필 정보가 저장되었어요 :)"
        let okTitle = "확인"
        showAlert(message: message, okTitle: okTitle, okCompletion: {
            self.sendNotification()
            self.navigationController?.popViewController(animated: true)
        })
    }
}

extension ProfileViewController {
    
    private func sendNotification() {
        print(#function)
        
        let notificationContent = UNMutableNotificationContent()
        
        let height = UserDefaults.height
        let weight = UserDefaults.weight
        let recommendedIntake: Double = Double(height + weight) / 100
        notificationContent.title = "물 마실 시간이에요!"
        notificationContent.body = "하루 \(recommendedIntake.round(notation: 10, digit: 2))리터 목표 달성을 위해 달려보아요"
        notificationContent.badge = 1
        
        addNotificationRequest(content: notificationContent, hour: 8, minute: 0)
        addNotificationRequest(content: notificationContent, hour: 12, minute: 0)
        addNotificationRequest(content: notificationContent, hour: 18, minute: 0)
    }
    
    private func addNotificationRequest(content: UNMutableNotificationContent, hour: Int, minute: Int, second: Int = 0) {
        
        var date = DateComponents()
        date.calendar = .autoupdatingCurrent
        date.timeZone = .autoupdatingCurrent
        date.hour = hour
        date.minute = minute
        date.second = second
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        let request = UNNotificationRequest(identifier: "\(String(describing: date.date))", // identifier 동일하면 덮어씌워짐
                                            content: content,
                                            trigger: trigger)
        
        userNotificationCenter.add(request) { error in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
}
