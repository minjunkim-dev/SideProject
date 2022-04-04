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
        
    let label = UILabel()
    
    func setupView() {
        
        backgroundColor = .systemGreen
        
        addSubview(label)
        label.text = "아아아 테스트입니다!"
        label.font = .systemFont(ofSize: 50)
    }
    
    func setupConstraints() {
        
        label.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
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
