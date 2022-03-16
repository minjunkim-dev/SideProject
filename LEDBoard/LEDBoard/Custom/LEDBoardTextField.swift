//
//  LEDBoardTextField.swift
//  LEDBoard
//
//  Created by beneDev on 2022/03/15.
//

import UIKit

final class LEDBoardTextField: UITextField {
    
    private let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    private func setupView() {
        
        textColor = .black
        attributedPlaceholder = NSAttributedString(
            string: "텍스트를 입력해주세요",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        autocapitalizationType = .none
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
}
