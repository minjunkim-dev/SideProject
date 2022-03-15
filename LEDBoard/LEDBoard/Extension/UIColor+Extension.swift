//
//  UIColor+Extension.swift
//  LEDBoard
//
//  Created by beneDev on 2022/03/15.
//

import UIKit

extension UIColor {
    
    static var random: UIColor {
        
        let threshold = 0.5 // 배경색이 검정색이라 텍스트 색상이 너무 어둡거나 연하면 안보이므로 임계점 설정
        
        return UIColor(
            red: .random(in: threshold...1),
            green: .random(in: threshold...1),
            blue: .random(in: threshold...1),
            alpha: .random(in: threshold...1)
        )
    }
}
