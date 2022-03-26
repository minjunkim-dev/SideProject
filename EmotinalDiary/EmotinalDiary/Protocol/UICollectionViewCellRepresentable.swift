//
//  UICollectionViewCellRepresentable.swift
//  EmotinalDiary
//
//  Created by beneDev on 2022/03/26.
//

import UIKit

@objc protocol UICollectionViewCellRepresentable {
    
    var numberOfItemsInSection: Int { get }
    
    @objc optional var numberOfSections: Int { get }
    
    @objc optional var sizeForItemAt: CGSize { get }
}
