//
//  UIView+Extension.swift
//  TrendMedia
//
//  Created by beneDev on 2022/04/11.
//

import UIKit

extension UIView {
    
    func setShadow(color: UIColor = .black, radius: CGFloat = 10, opacity: Float = 0.5, offset: CGSize = .zero) {
        
        self.layer.masksToBounds = false
        
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
    }
}
