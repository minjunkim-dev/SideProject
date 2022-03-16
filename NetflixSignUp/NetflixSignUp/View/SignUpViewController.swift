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
        
        scrollView.backgroundColor = .black
        mainView.backgroundColor = .black
        
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
        
        mainView.signUpButtion.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
        mainView.moreInfoSwitch.addTarget(self, action: #selector(moreInfoSwitchClicked(_:)), for: .valueChanged)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    
        for (index, subView) in mainView.stackView.arrangedSubviews.enumerated() {
            guard let textField = subView as? UITextField else { return }
            
            textField.delegate = self
            
            if index == 0 {
                textField.addTarget(self, action: #selector(idTextFieldEditingChanged(_:)), for: .editingChanged)
                viewModel.identifier.bind { textField.text = $0 }
                
            } else if index == 1 {
                textField.addTarget(self, action: #selector(pwTextFieldEditingChanged(_:)), for: .editingChanged)
                viewModel.password.bind { textField.text = $0 }
                
            } else if index == 2 {
                textField.addTarget(self, action: #selector(nicknameTextFieldEditingChanged(_:)), for: .editingChanged)
                viewModel.nickname.bind { textField.text = $0 }
                
            } else if index == 3 {
                textField.addTarget(self, action: #selector(locationTextFieldEditingChanged(_:)), for: .editingChanged)
                viewModel.location.bind { textField.text = $0 }
                
            } else {
                textField.addTarget(self, action: #selector(referralCodeTextFieldEditingChanged(_:)), for: .editingChanged)
                viewModel.referralCode.bind { textField.text = $0 }
               
            }
        }
    }
    
    @objc private func idTextFieldEditingChanged(_ textField: UITextField) {
        
        let maxLength = max(SignUpUserInfoValid.email.range.upperBound, SignUpUserInfoValid.phoneNumber.range.upperBound)
          
        guard let text = textField.text, text.count <= maxLength else {
            textField.deleteBackward()
            return
        }

        viewModel.identifier.value = textField.text ?? ""
    }
    
    @objc private func pwTextFieldEditingChanged(_ textField: UITextField) {
        
        let maxLength = SignUpUserInfoValid.password.range.upperBound
          
        guard let text = textField.text, text.count <= maxLength else {
            textField.deleteBackward()
            return
        }
        
        viewModel.password.value = textField.text ?? ""
    }
    
    @objc private func nicknameTextFieldEditingChanged(_ textField: UITextField) {
        
        let maxLength = SignUpUserInfoValid.nickname.range.upperBound
          
        guard let text = textField.text, text.count <= maxLength else {
            textField.deleteBackward()
            return
        }
        
        viewModel.nickname.value = textField.text ?? ""
    }
    
    @objc private func locationTextFieldEditingChanged(_ textField: UITextField) {
        
        let maxLength = SignUpUserInfoValid.location.range.upperBound
          
        guard let text = textField.text, text.count <= maxLength else {
            textField.deleteBackward()
            return
        }
        
        viewModel.location.value = textField.text ?? ""
    }
    
    @objc func referralCodeTextFieldEditingChanged(_ textField: UITextField) {
        
        let maxLength = SignUpUserInfoValid.referralCode.range.upperBound
          
        guard let text = textField.text, text.count <= maxLength else {
            textField.deleteBackward()
            return
        }
        
        viewModel.referralCode.value = textField.text ?? ""
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

    @objc private func signUpButtonClicked() {
        print(#function)
        
        let (isValid, invalidType) = viewModel.validateRequiredUserInfo()
        
        if !isValid, let type = invalidType {
            
            var message = String()
            
            switch type {
            case .notEnteredIDorPassword:
                message = "아이디와 비밀번호를 모두 입력해주세요."
            case .identifierInvalid:
                message = "아이디 형식이 올바른지 확인해주세요."
            case .passwordInvalid:
                message = "비밀번호 형식이 올바른지 확인해주세요."
            }
            
            self.showAlert(title: nil, message: message, okTitle: "확인", okCompletion: nil, cancleTitle: nil, cancleCompletion: nil)
            
            return
        }
        
        /* 추가 정보 입력을 하고자 하는 경우에만 유효성 검사 필요 */
        if mainView.moreInfoSwitch.isOn {
            
            let (isValid, invalidType) = viewModel.validateAdditionalUserInfo()
            
            if !isValid, let type = invalidType {
                
                var message = String()
                
                switch type {
                case .nicknameInvalid:
                    message = "닉네임 형식이 올바른지 확인해주세요."
                case .locationInvalid:
                    message = "위치 형식이 올바른지 확인해주세요."
                case .refferalCodeInvalid:
                    message = "추천 코드 형식이 올바른지 확인해주세요."
                }
                
                self.showAlert(title: nil, message: message, okTitle: "확인", okCompletion: nil, cancleTitle: nil, cancleCompletion: nil)
                
                return
            }
        }
        
        showAlert(title: nil, message:  "회원가입이 완료되었습니다.", okTitle: "확인", okCompletion: nil, cancleTitle: nil, cancleCompletion: nil)
        
        
        /* 콘솔로 결과 확인하는 용도 */
        print("회원가입 정보 확인")
        
        print("ID: \(viewModel.user.identifier)")
        print("PW: \(viewModel.user.password)")
        
        if mainView.moreInfoSwitch.isOn {
            if let nickname = viewModel.user.nickname, !(nickname.isEmpty) {
                print("NICK: \(nickname)")
            }
            if let location = viewModel.user.location, !(location.isEmpty) {
                print("LOCATION: \(location)")
                
            }
            if let referralCode = viewModel.user.referralCode, !(referralCode.isEmpty) {
                print("CODE: \(referralCode)")

            }
        }
    }
    
    @objc private func moreInfoSwitchClicked(_ sender: UISwitch) {
        print(#function)
        
        UIView.animate(withDuration: 0.5) {
            self.mainView.stackView.arrangedSubviews[2].isHidden = !(sender.isOn)
            self.mainView.stackView.arrangedSubviews[3].isHidden = !(sender.isOn)
            self.mainView.stackView.arrangedSubviews[4].isHidden = !(sender.isOn)
        }
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
