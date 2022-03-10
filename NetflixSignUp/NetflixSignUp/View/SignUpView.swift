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
        $0.textColor = .red
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 40, weight: .heavy)
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
        backgroundColor = .black
        
        addSubview(titleLabel)
        titleLabel.text = "JUNFLIX"
        
    }
    
    private func setupConstaints() {
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.5)
            $0.horizontalEdges.lessThanOrEqualToSuperview().inset(20)
        }
    }
}
