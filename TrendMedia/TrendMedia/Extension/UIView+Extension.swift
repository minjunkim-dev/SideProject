//
//  UIView+Extension.swift
//  TrendMedia
//
//  Created by beneDev on 2022/04/11.
//

import UIKit

extension UIView {
    
    func setShadow(color: UIColor = .black, radius: CGFloat = 5, opacity: Float = 0.5, offset: CGSize = .zero) {
        
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        
        self.layer.masksToBounds = false
    }
}
