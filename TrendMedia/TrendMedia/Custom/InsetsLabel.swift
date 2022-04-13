//
//  InsetsLabel.swift
//  TrendMedia
//
//  Created by beneDev on 2022/04/13.
//

import UIKit

final class InsetsLabel: UILabel {
    
    var topInset: CGFloat = 5
    var bottomInset: CGFloat = 5
    var leftInset: CGFloat = 5
    var rightInset: CGFloat = 5
 
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset, height: size.height + topInset + bottomInset)
    }

    override var bounds: CGRect {
        didSet { preferredMaxLayoutWidth = bounds.width - (leftInset + rightInset) }
    }
}
