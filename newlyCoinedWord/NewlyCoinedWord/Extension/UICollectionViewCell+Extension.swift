//
//  UICollectionViewCell+Extension+Extension.swift
//  NewlyCoinedWord
//
//  Created by beneDev on 2022/03/16.
//

import UIKit

extension UICollectionViewCell: ReusableView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
