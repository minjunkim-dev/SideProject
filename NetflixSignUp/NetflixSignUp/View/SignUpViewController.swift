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
    
    @objc func idTextFieldEditingChanged(_ textField: UITextField) {
        
        let maxLength = max(SignUpValidationType.email.range.upperBound, SignUpValidationType.phoneNumber.range.upperBound)
          
        guard let text = textField.text, text.count <= maxLength else {
            textField.deleteBackward()
            return
        }

        viewModel.identifier.value = textField.text ?? ""
    }
    
    @objc func pwTextFieldEditingChanged(_ textField: UITextField) {
        
        let maxLength = SignUpValidationType.password.range.upperBound
          
        guard let text = textField.text, text.count <= maxLength else {
            textField.deleteBackward()
            return
        }
        
        viewModel.password.value = textField.text ?? ""
    }
    
    @objc func nicknameTextFieldEditingChanged(_ textField: UITextField) {
        
        let maxLength = SignUpValidationType.nickname.range.upperBound
          
        guard let text = textField.text, text.count <= maxLength else {
            textField.deleteBackward()
            return
        }
        
        viewModel.nickname.value = textField.text ?? ""
    }
    
    @objc func locationTextFieldEditingChanged(_ textField: UITextField) {
        
        let maxLength = SignUpValidationType.location.range.upperBound
          
        guard let text = textField.text, text.count <= maxLength else {
            textField.deleteBackward()
            return
        }
        
        viewModel.location.value = textField.text ?? ""
    }
    
    @objc func referralCodeTextFieldEditingChanged(_ textField: UITextField) {
        
        let maxLength = SignUpValidationType.referralCode.range.upperBound
          
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

    @objc func signUpButtonClicked() {
        print(#function)
        
        if !(validateRequiredUserInfo()) { return }
        
        /* 추가 정보 입력을 하고자 하는 경우에만 유효성 검사 필요 */
        if mainView.moreInfoSwitch.isOn {
            if !(validateAdditionalUserInfo()) { return }
        }
        
        
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
        
        showAlert(title: nil, message:  "회원가입이 완료되었습니다.", okTitle: "확인", okCompletion: nil, cancleTitle: nil, cancleCompletion: nil)
    }
    
    func validateRequiredUserInfo() -> Bool {
        /* 아이디와 비밀번호는 필수 기입 */
        guard !(viewModel.identifier.value.isEmpty),
              !(viewModel.password.value.isEmpty) else {
            showAlert(title: nil, message: "아이디와 비밀번호를 모두 입력해주세요.", okTitle: "확인", okCompletion: nil, cancleTitle: nil, cancleCompletion: nil)
            return false
        }
        
        let emailRegex = SignUpValidationType.email.regex
        let phoneNumberRegex = SignUpValidationType.phoneNumber.regex
        
        let passwordRegex = SignUpValidationType.password.regex
        
        if !(SignUpValidationType.validate(value: viewModel.identifier.value, regex: emailRegex) || SignUpValidationType.validate(value: viewModel.identifier.value, regex: phoneNumberRegex)) {
            showAlert(title: nil, message: "아이디 형식이 올바른지 확인해주세요.", okTitle: "확인", okCompletion: nil, cancleTitle: nil, cancleCompletion: nil)
            
            return false
        }
        
        if !(SignUpValidationType.validate(value: viewModel.password.value, regex: passwordRegex)) {
    
            showAlert(title: nil, message: "비밀번호 형식이 올바른지 확인해주세요.", okTitle: "확인", okCompletion: nil, cancleTitle: nil, cancleCompletion: nil)
            return false
        }
        
        viewModel.user.identifier = viewModel.identifier.value
        viewModel.user.password = viewModel.password.value
        
        return true
    }
    
    func validateAdditionalUserInfo() -> Bool {
        
        let nicknameRegex = SignUpValidationType.nickname.regex
        let locationRegex = SignUpValidationType.location.regex
        let referralRegex = SignUpValidationType.referralCode.regex
        
        if let nickname = viewModel.nickname.value, !(nickname.isEmpty) {
            if !(SignUpValidationType.validate(value: nickname, regex: nicknameRegex)) {
                showAlert(title: nil, message: "닉네임 형식이 올바른지 확인해주세요.", okTitle: "확인", okCompletion: nil, cancleTitle: nil, cancleCompletion: nil)
                return false
            }
        }
       
        
        if let location = viewModel.location.value, !(location.isEmpty) {
            if !(SignUpValidationType.validate(value: location, regex: locationRegex)) {
                
                showAlert(title: nil, message: "위치 형식이 올바른지 확인해주세요.", okTitle: "확인", okCompletion: nil, cancleTitle: nil, cancleCompletion: nil)
                return false
            }
        }
        
        
        if let referralCode = viewModel.referralCode.value, !(referralCode.isEmpty) {
            if !(SignUpValidationType.validate(value: referralCode, regex: referralRegex)) {
                
                showAlert(title: nil, message: "추천코드 형식이 올바른지 확인해주세요.", okTitle: "확인", okCompletion: nil, cancleTitle: nil, cancleCompletion: nil)
                return false
            }
        }
        
        
        viewModel.user.nickname = viewModel.nickname.value
        viewModel.user.location = viewModel.location.value
        viewModel.user.referralCode = viewModel.referralCode.value
        
        return true
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
