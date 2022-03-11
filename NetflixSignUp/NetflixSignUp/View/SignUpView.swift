//
//  SignUpView.swift
//  NetflixSignUp
//
//  Created by beneDev on 2022/03/09.
//

import UIKit

import SnapKit
import Then

final class SignUpView: UIView {
 
    let titleLabel = UILabel().then {
        $0.text = "JUNFLIX"
        $0.textColor = .red
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 40, weight: .heavy)
    }
    
    
    /* 필수정보 */
    let idTextField = UserInfoTextField().then {
        $0.attributedPlaceholder = NSAttributedString(
            string: "이메일 주소 또는 전화번호",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        $0.keyboardType = .emailAddress
    }
    let pwTextField = UserInfoTextField().then {
        $0.attributedPlaceholder = NSAttributedString(
            string: "비밀번호",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        $0.keyboardType = .default
        $0.isSecureTextEntry = true
    }
    
    /* 추가정보 */
    let nicknameTextField = UserInfoTextField().then {
        $0.attributedPlaceholder = NSAttributedString(
            string: "닉네임",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        $0.keyboardType = .default
    }
    let locationTextField = UserInfoTextField().then {
        $0.attributedPlaceholder = NSAttributedString(
            string: "위치",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        $0.keyboardType = .default
    }
    let referralTexrField = UserInfoTextField().then {
        $0.attributedPlaceholder = NSAttributedString(
            string: "추천 코드 입력",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        $0.keyboardType = .default
    }
    
    let stackView = UIStackView().then {
        $0.alignment = .center
        $0.distribution = .equalSpacing
        $0.spacing = 20
        $0.axis = .vertical
    }
    
    let signUpButtion = UIButton().then {
        $0.backgroundColor = .white
        $0.setTitle("회원가입", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 18, weight: .heavy)
        $0.setTitleColor(.black, for: .normal)
        $0.layer.cornerRadius = 5
    }
    
    let moreInfoLabel = UILabel().then {
        $0.backgroundColor = .clear
        $0.text = "추가 정보 입력"
        $0.textColor = .white
        $0.textAlignment = .center
    }
    
    let moreInfoSwitch = UISwitch().then {
        $0.thumbTintColor = .white
        $0.onTintColor = .red
        $0.isOn = true
        
        /* off시 tintColor를 설정하기 위함 */
        $0.backgroundColor = .darkGray
        $0.layer.cornerRadius = $0.frame.height / 2
        $0.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstaints()
    }
    
    private func setupView() {
    
        addSubview(titleLabel)
        
        addSubview(stackView)
        [
            idTextField, pwTextField,
            nicknameTextField, locationTextField, referralTexrField,
        ]
            .forEach { stackView.addArrangedSubview($0) }
        
        addSubview(signUpButtion)
        
        addSubview(moreInfoLabel)
        addSubview(moreInfoSwitch)
  
    }
    
    private func setupConstaints() {

        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide).inset(80)
            $0.horizontalEdges.lessThanOrEqualToSuperview().inset(40)
        }
        
        stackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(80)
            $0.horizontalEdges.lessThanOrEqualToSuperview().inset(40)
        }
        
        [
            idTextField, pwTextField,
            nicknameTextField, locationTextField, referralTexrField,
        ].forEach {
            $0.snp.makeConstraints {
                $0.horizontalEdges.equalToSuperview()
                $0.height.equalTo(40)
            }
        }
        
        signUpButtion.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(stackView.snp.bottom).offset(20)
            $0.horizontalEdges.lessThanOrEqualToSuperview().inset(40)
            $0.height.equalTo(50)
        }
        
        moreInfoLabel.snp.makeConstraints {
            $0.leading.equalTo(signUpButtion)
            $0.top.equalTo(signUpButtion.snp.bottom).offset(20)
        }
        
        moreInfoSwitch.snp.makeConstraints {
            $0.trailing.equalTo(signUpButtion)
            $0.centerY.equalTo(moreInfoLabel)
            $0.bottom.lessThanOrEqualToSuperview().inset(80)
        }
    }
}
