//
//  ProfileView.swift
//  DrinkWater
//
//  Created by beneDev on 2022/04/04.
//

import UIKit

final class ProfileView: UIView, ViewPrenstable {
    
    let profileImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        
        $0.image = Assets.phase1.image
    }
    
    let profileStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 20
        $0.distribution = .equalSpacing
    }
    
    let infoList = [
        UserInfo.nickname,
        UserInfo.height,
        UserInfo.weight,
    ]
    
    func setupView() {
        
        backgroundColor = .systemGreen
        
        addSubview(profileImageView)
        
        addSubview(profileStackView)
        infoList.forEach { info in
            let profileInputView = ProfileInputView(info: info)
            profileStackView.addArrangedSubview(profileInputView)
        }
    }
    
    func setupConstraints() {
        
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(40)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(self.snp.height).multipliedBy(0.15)
        }
        
        profileStackView.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(40)
            $0.horizontalEdges.equalToSuperview().inset(40)
            $0.bottom.lessThanOrEqualToSuperview().inset(40)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
