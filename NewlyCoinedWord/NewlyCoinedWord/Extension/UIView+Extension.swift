//
//  UIView+Extension.swift
//  NewlyCoinedWord
//
//  Created by beneDev on 2022/03/28.
//

import UIKit

extension UIView {
    func transition (_ duration: CFTimeInterval) {
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.type = .fade
        animation.subtype = .none
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.push.rawValue)
    }
}
