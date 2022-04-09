//
//  UIView+Extension.swift
//  DrinkWater
//
//  Created by beneDev on 2022/04/06.
//

import UIKit

extension UIView {
    
    func transition (_ duration: CFTimeInterval, _ type: CATransitionType, _ subtype: CATransitionSubtype?) {
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.type = type
        animation.subtype = subtype
        animation.duration = duration
        layer.add(animation, forKey: type.rawValue)
    }
}

