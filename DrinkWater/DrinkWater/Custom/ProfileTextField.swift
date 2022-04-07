//
//  ProfileTextField.swift
//  DrinkWater
//
//  Created by beneDev on 2022/04/04.
//

import UIKit

import SnapKit
import Then

final class ProfileTextField: UITextField, ViewPrenstable {
    
    let underlineView = UIView().then {
        $0.backgroundColor = .systemRed
    }
    
    func setupView() {
        textColor = .white
        textAlignment = .left
        autocapitalizationType = .none
     
        addSubview(underlineView)
    }
    
    func setupConstraints() {
        
        underlineView.snp.makeConstraints {
            $0.top.equalTo(self.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
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
