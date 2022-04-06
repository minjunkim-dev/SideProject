//
//  UIViewController+Extension.swift
//  DrinkWater
//
//  Created by beneDev on 2022/04/06.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String? = nil, message: String? = nil, okTitle: String, okCompletion: (() -> Void)? = nil, cancleTitle: String? = nil, cancleCompletion: (() -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if let cancleTitle = cancleTitle {
            let cancleAction = UIAlertAction(title: cancleTitle, style: .destructive) {_ in
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
    
    func showActionSheet(title: String? = nil, message: String? = nil, okTitle: String, okCompletion: (() -> Void)? = nil, cancleTitle: String? = nil, cancleCompletion: (() -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        if let cancleTitle = cancleTitle {
            let cancleAction = UIAlertAction(title: cancleTitle, style: .destructive) {_ in
                cancleCompletion?()
            }
            alert.addAction(cancleAction)
        }
        
        let okAction = UIAlertAction(title: okTitle, style: .default) { _ in
            okCompletion?()
        }
        
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
}
