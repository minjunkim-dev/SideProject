//
//  SignUpViewController.swift
//  NetflixSignUp
//
//  Created by beneDev on 2022/03/09.
//

import UIKit

import SnapKit

final class SignUpViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let mainView = SignUpView()
    private let viewModel = SignUpViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.backgroundColor = .systemOrange
        mainView.backgroundColor = .systemIndigo
        
        scrollView.alwaysBounceVertical = true // set always scrollable
        scrollView.keyboardDismissMode = .onDrag
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        scrollView.addSubview(mainView)
        mainView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            
            /* 수직 스크롤을 위해 너비는 고정 */
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        mainView.stackView.arrangedSubviews.forEach {
            if let textField = $0 as? UITextField { textField.delegate = self }
        }
        
        mainView.signUpButtion.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
        mainView.moreInfoSwitch.addTarget(self, action: #selector(moreInfoSwitchClicked(_:)), for: .valueChanged)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        addKeyboardNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
//        removeKeyboardNotification()
    }
    
    override func dismissKeyboard() {
        super.dismissKeyboard()
        
        scrollView.scrollVertically(position: .zero)
    }

    @objc func signUpButtonClicked() {
        print(#function)
        print("회원가입 정보 확인")
        
        print("ID: \(viewModel.user.identifier)")
        print("PW: \(viewModel.user.password)")
        
        if let nickname = viewModel.user.nickname { print("NICK: \(nickname)") }
        if let location = viewModel.user.location { print("LOCATION: \(location)") }
        if let referralCode = viewModel.user.referralCode { print("CODE: \(referralCode)") }
    }
    
    @objc func moreInfoSwitchClicked(_ sender: UISwitch) {
        print(#function)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.mainView.stackView.arrangedSubviews[2].isHidden = !(sender.isOn)
            self.mainView.stackView.arrangedSubviews[3].isHidden = !(sender.isOn)
            self.mainView.stackView.arrangedSubviews[4].isHidden = !(sender.isOn)
        })
    
    }
}

extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(#function)
        
        let position = CGPoint(x: 0, y: textField.frame.maxY + textField.frame.height)
        scrollView.scrollVertically(position: position)
    }
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(#function)
        
        dismissKeyboard()
        
        return true
    }
}
