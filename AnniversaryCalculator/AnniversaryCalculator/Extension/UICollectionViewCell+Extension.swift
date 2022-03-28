//
//  UICollectionViewCell+Extension.swift
//  AnniversaryCalculator
//
//  Created by beneDev on 2022/03/28.
//

import UIKit

extension UICollectionViewCell: ReusableView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
