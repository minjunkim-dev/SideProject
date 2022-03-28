//
//  AnniversaryView.swift
//  AnniversaryCalculator
//
//  Created by beneDev on 2022/03/27.
//

import UIKit

final class AnniversaryView: UIView, ViewPresentable {
    
    func setupView() {
        
        backgroundColor = .systemIndigo
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
