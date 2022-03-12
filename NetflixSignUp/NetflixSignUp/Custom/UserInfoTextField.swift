//
//  UserInfoTextField.swift
//  NetflixSignUp
//
//  Created by beneDev on 2022/03/10.
//

import UIKit

final class UserInfoTextField: UITextField {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }
    
    private func setupView() {
        
        let color = UIColor.white
        self.textColor = color
        
        self.textAlignment = .center
        self.backgroundColor = .darkGray
        self.borderStyle = .roundedRect
        self.autocapitalizationType = .none
    }
}
