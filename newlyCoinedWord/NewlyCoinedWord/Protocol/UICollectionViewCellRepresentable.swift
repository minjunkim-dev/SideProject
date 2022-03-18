//
//  UICollectionViewCellRepresentable.swift
//  NewlyCoinedWord
//
//  Created by beneDev on 2022/03/18.
//

import UIKit

@objc protocol UICollectionViewCellRepresentable {
    
    var numberOfItemsInSection: Int { get }
    
    func cellForItemAt(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> UICollectionViewCell
    
    @objc optional var numberOfSections: Int { get }
    
    @objc optional var sizeForItemAt: CGSize { get }

    @objc optional var minimumLineSpacingForSectionAt: CGFloat { get }
    
    @objc optional var minimumInteritemSpacingForSectionAt: CGFloat { get }
    
    @objc optional var insetForSectionAt: UIEdgeInsets { get }
    
    @objc optional var referenceSizeForHeaderInSection: CGSize { get }
    
    @objc optional var referenceSizeForFooterInSection: CGSize { get }
}
