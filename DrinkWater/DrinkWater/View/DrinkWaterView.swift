//
//  DrinkWaterView.swift
//  DrinkWater
//
//  Created by beneDev on 2022/04/04.
//

import UIKit

import SnapKit
import Then

final class DrinkWaterView: UIView, ViewPrenstable {
    
    let todayIntakeLabel = UILabel().then {
        $0.numberOfLines = 4
        $0.textColor = .white
        $0.textAlignment = .left
    }
    
    let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        
        $0.image = Assets.phase1.image
    }
    
    let inputIntakeTextField = UITextField().then {
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 30, weight: .regular)
        $0.placeholder = "ml"
        
        $0.autocapitalizationType = .none
        $0.keyboardType = .numberPad
        $0.doneAccessory = true
    }
    
    let recommendedIntakeLabel = UILabel().then {
        $0.numberOfLines = 1
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 14, weight: .regular)
    }
    
    let addIntakeButton = UIButton().then {
        $0.setTitle("물 마시기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        $0.backgroundColor = .white
    }
    
    func setupView() {
        
        backgroundColor = .systemGreen
        
        [todayIntakeLabel, imageView, inputIntakeTextField, recommendedIntakeLabel, addIntakeButton].forEach {
            addSubview($0)
        }
    }
    
    func setupConstraints() {
        
        todayIntakeLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(40)
            $0.leading.equalTo(safeAreaLayoutGuide).inset(20)
            $0.trailing.equalTo(self.snp.centerX)
            $0.bottom.lessThanOrEqualTo(imageView.snp.top).offset(-20)
        }
        
        imageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(self).multipliedBy(0.3)
        }
        
        inputIntakeTextField.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(40)
            $0.bottom.lessThanOrEqualTo(recommendedIntakeLabel.snp.top).offset(-20)
        }
        
        recommendedIntakeLabel.snp.makeConstraints {
            $0.bottom.equalTo(addIntakeButton.snp.top).offset(-10)
            $0.horizontalEdges.lessThanOrEqualTo(safeAreaLayoutGuide).inset(20)
            $0.centerX.equalToSuperview()
        }
        
        addIntakeButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(50)
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
