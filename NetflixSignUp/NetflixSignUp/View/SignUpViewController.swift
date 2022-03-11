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
        
        scrollView.backgroundColor = .green
        mainView.backgroundColor = .blue
        
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
    }
}
