//
//  Double+Extension.swift
//  DrinkWater
//
//  Created by beneDev on 2022/04/06.
//

import Foundation

extension Double {
    
    func round(notation: Double, digit: Double) -> Double {
        
        let divider: Double = pow(notation, digit)
        return (self * divider) / divider
    }
}
