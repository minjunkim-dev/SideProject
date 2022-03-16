//
//  newlyCoinedWordView.swift
//  newlyCoinedWord
//
//  Created by beneDev on 2022/03/16.
//

import UIKit

import SnapKit
import Then

final class newlyCoinedWordView: UIView {
    
    private func setupView() {
        backgroundColor = .white
    }
    
    private func setupConstraints() {
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
}
