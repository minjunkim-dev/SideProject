//
//  SummaryMediaView.swift
//  TrendMedia
//
//  Created by beneDev on 2022/04/11.
//

import UIKit

final class SummaryMediaView: UIView, ViewPresentable {
    
    func setupView() {
        backgroundColor = .white
        
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

