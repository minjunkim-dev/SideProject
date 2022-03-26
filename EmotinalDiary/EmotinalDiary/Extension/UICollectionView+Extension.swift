//
//  UICollectionView+Extension.swift
//  EmotinalDiary
//
//  Created by beneDev on 2022/03/26.
//

import UIKit

extension UICollectionViewCell: ReusableView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
