//
//  UIViewController+Extension.swift
//  NewlyCoinedWord
//
//  Created by beneDev on 2022/03/18.
//

import UIKit

extension UIViewController {
    
    @objc func dismissKeyboard() {
    
        view.endEditing(true)
    }
    
    func showAlert(title: String?, message: String, okTitle: String, okCompletion: (() -> Void)?, cancleTitle: String?, cancleCompletion: (() -> Void)?) {
        
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
    
    
    func openSettings() {
        
        if let url = URL.init(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
