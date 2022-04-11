//
//  UIViewController+Extension.swift
//  TrendMedia
//
//  Created by beneDev on 2022/04/11.
//

import UIKit

extension UIViewController {
    
    func configureNavigation(title: String? = nil, titleColor: UIColor? = nil, titleFont: UIFont? = nil, leftItems: [UIBarButtonItem]? = nil, rightItems: [UIBarButtonItem]? = nil, barTintColor: UIColor? = nil) {
        
        navigationItem.title = title
        
        if let titleColor = titleColor, let titleFont = titleFont {
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: titleColor, .font: titleFont]
        }
        
        navigationItem.leftBarButtonItems = leftItems
        navigationItem.rightBarButtonItems = rightItems
        
        if let barTintColor = barTintColor {
            navigationController?.navigationBar.tintColor = barTintColor
        }
    }
}
