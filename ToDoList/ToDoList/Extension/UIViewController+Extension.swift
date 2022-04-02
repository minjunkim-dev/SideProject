//
//  UIViewController+Extension.swift
//  ToDoList
//
//  Created by beneDev on 2022/04/02.
//

import UIKit

extension UIViewController {
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showAlert(title: String? = nil, message: String, okTitle: String, okCompletion: (() -> Void)? = nil, cancleTitle: String? = nil, cancleCompletion: (() -> Void)? = nil) {
        
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
}
