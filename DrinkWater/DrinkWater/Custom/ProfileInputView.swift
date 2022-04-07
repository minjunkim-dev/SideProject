//
//  ProfileInputView.swift
//  DrinkWater
//
//  Created by beneDev on 2022/04/04.
//

import UIKit

import SnapKit
import Then

final class ProfileInputView: UIView, ViewPrenstable {
    
    let titleLabel = UILabel().then {
        $0.textAlignment = .left
        $0.textColor = .white
        $0.numberOfLines = 1
    }
    
    let textField = ProfileTextField()
    
    private var info: UserInfo
    private let validator = UserInfoValidator.shared
    
    func setupView() {
        
        [titleLabel, textField].forEach {
            addSubview($0)
        }
        titleLabel.text = self.info.title
        
        switch self.info {
        case .nickname:
            textField.text = UserDefaults.nickname
            textField.keyboardType = .default
            textField.doneAccessory = false
        case .height:
            textField.text = UserDefaults.height != UserDefaults.$height ? String(UserDefaults.height) : ""
            textField.keyboardType = .numberPad
            textField.doneAccessory = true
        case .weight:
            textField.text = UserDefaults.weight != UserDefaults.$weight ? String(UserDefaults.weight) : ""
            textField.keyboardType = .numberPad
            textField.doneAccessory = true
        case .intake:
            break
        }
        
        validateText()
    }
    
    func setupConstraints() {
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.lessThanOrEqualToSuperview()
            $0.bottom.equalTo(textField.snp.top).offset(-10)
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    init(frame: CGRect = .zero, info: UserInfo) {
        self.info = info
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
        
        textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        textField.addTarget(self, action: #selector(textFieldEditingDidEndOnExit), for: .editingDidEndOnExit)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension ProfileInputView {
    
    private func validateText() {
        let regex = validator.regex(info: self.info)
        if let text = textField.text, validator.validate(target: text, regex: regex) {
            textField.underlineView.backgroundColor = .white
            textField.underlineView.snp.updateConstraints {
                $0.height.equalTo(2)
            }
        } else {
            textField.underlineView.backgroundColor = .systemRed
            textField.underlineView.snp.updateConstraints {
                $0.height.equalTo(1)
            }
        }
    }
    
    @objc private func textFieldEditingChanged() {
        print(#function)
        
        let maxLength = validator.range(info: info).upperBound
        guard let text = textField.text, text.count <= maxLength else {
            textField.deleteBackward()
            return
        }
        textField.text = text
      
        validateText()
    }
    
    // for dismissing keyboard when returnKey clicked
    @objc private func textFieldEditingDidEndOnExit() {
        print(#function)
        
    }
}
