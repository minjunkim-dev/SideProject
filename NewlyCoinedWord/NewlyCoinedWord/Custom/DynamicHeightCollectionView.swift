//
//  DynamicHeightCollectionView.swift
//  NewlyCoinedWord
//
//  Created by beneDev on 2022/03/18.
//

import UIKit

final class DynamicHeightCollectionView: UICollectionView {
    
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
