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
    
    func openSettings() {
        
        if let url = URL.init(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func showAlert(title: String?, message: String?, okTitle: String, okCompletion: (() -> Void)?, cancleTitle: String?, cancleCompletion: (() -> Void)?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if let cancleTitle = cancleTitle {
            let cancleAction = UIAlertAction(title: cancleTitle, style: .destructive) { _ in
             
                cancleCompletion?()
            }
            alert.addAction(cancleAction)
        }
        
        let okAction = UIAlertAction(title: okTitle, style: .cancel) { _ in
            
            okCompletion?()
        }
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func setNavBackButtonTitle(title: String?) {
        let backBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .black
        navigationItem.backBarButtonItem = backBarButtonItem
    }
}
