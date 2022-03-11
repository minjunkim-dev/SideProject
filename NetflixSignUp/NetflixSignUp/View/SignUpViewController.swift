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
        mainView.moreInfoSwitch.addTarget(self, action: #selector(moreInfoSwitchClicked), for: .valueChanged)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
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
    
    @objc func moreInfoSwitchClicked() {
        print(#function)
    }
}
