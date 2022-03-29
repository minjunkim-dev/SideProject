//
//  LEDBoardButton.swift
//  LEDBoard
//
//  Created by beneDev on 2022/03/15.
//

import UIKit

final class LEDBoardButton: UIButton {
    
    private func setupView() {
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
}


