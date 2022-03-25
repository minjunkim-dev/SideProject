//
//  DiaryView.swift
//  EmotinalDiary
//
//  Created by beneDev on 2022/03/25.
//

import UIKit

import SnapKit
import Then

class DiaryView: UIView, ViewPresentable {
    
    func setupView() {
        backgroundColor = .orange
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
