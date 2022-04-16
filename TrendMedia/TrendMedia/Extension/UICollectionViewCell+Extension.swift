//
//  UICollectionViewCell+Extension.swift
//  TrendMedia
//
//  Created by beneDev on 2022/04/16.
//

import UIKit

extension UICollectionViewCell: ReusableView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
