//
//  DrinkWaterView.swift
//  DrinkWater
//
//  Created by beneDev on 2022/04/04.
//

import UIKit

final class DrinkWaterView: UIView, ViewPrenstable {
    
    func setupView() {
        
        backgroundColor = .systemGreen
    }
    
    func setupConstraints() {
        
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
