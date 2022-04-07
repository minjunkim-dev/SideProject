//
//  String+Extension.swift
//  DrinkWater
//
//  Created by beneDev on 2022/04/06.
//

import UIKit

extension NSMutableAttributedString {

    func attributedText(target: String, font: UIFont, color: UIColor) -> NSMutableAttributedString {
    
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: color,
        ]
        
        self.append(NSAttributedString(string: target, attributes: attributes))
        return self
    }
}
