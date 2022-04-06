//
//  String+Extension.swift
//  DrinkWater
//
//  Created by beneDev on 2022/04/06.
//

import Foundation

extension String {
    
    func validate(regex: String) -> Bool {
        
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        return test.evaluate(with: self)
    }
}
