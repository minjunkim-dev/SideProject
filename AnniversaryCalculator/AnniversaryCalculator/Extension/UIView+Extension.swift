//
//  UIView+Extension.swift
//  AnniversaryCalculator
//
//  Created by beneDev on 2022/03/28.
//

import UIKit

extension UIView {
    func pushTransition (_ duration: CFTimeInterval, _ subtype: CATransitionSubtype?) {
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.type = .push
        animation.subtype = subtype
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.push.rawValue)
    }
}
