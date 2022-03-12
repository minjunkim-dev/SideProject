//
//  UIScrollView+Extension.swift
//  NetflixSignUp
//
//  Created by beneDev on 2022/03/12.
//

import UIKit

extension UIScrollView {
    
    func scrollVertically(position: CGPoint) {
        setContentOffset(position, animated: true)
    }
}
