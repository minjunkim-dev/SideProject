//
//  UICollectionViewCellRepresentable.swift
//  AnniversaryCalculator
//
//  Created by beneDev on 2022/03/28.
//

import UIKit

@objc protocol UICollectionViewCellRepresentable {
    
    var numberOfItemsInSection: Int { get }
    
    @objc optional var numberOfSections: Int { get }
}
