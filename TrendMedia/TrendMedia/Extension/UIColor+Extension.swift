//
//  UIColor+Extension.swift
//  TrendMedia
//
//  Created by beneDev on 2022/04/16.
//

import UIKit

extension UIColor {
    
    static var random: UIColor {
        
        let threshold = 0.75
        return UIColor(
            red: .random(in: threshold...1),
            green: .random(in: threshold...1),
            blue: .random(in: threshold...1),
            alpha: .random(in: threshold...1)
        )
    }
}
