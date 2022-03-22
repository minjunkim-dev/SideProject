//
//  UICollectionViewCellRepresentable.swift
//  NewlyCoinedWord
//
//  Created by beneDev on 2022/03/18.
//

import UIKit

/* viewModel에서 채택하여 사용할 것이므로,
 데이터와 연관된 것만 정의하고 뷰와 연관된 것은 뷰컨트롤러에서 직접 정의 및 구현하여 사용하자!
 */
@objc protocol UICollectionViewCellRepresentable {
    
    var numberOfItemsInSection: Int { get }
    
    @objc optional var numberOfSections: Int { get }
    
    @objc optional var sizeForItemAt: CGSize { get }
}
