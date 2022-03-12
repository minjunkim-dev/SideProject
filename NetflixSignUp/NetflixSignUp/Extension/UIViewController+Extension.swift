//
//  UIViewController+Extension.swift
//  NetflixSignUp
//
//  Created by beneDev on 2022/03/11.
//

import UIKit

extension UIViewController {
    
    @objc func dismissKeyboard() {
        print(#function)
        
        view.endEditing(true)
    }
    
    func addKeyboardNotification() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        print(#function)
        
        if let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let rect = frame.cgRectValue
            let height = rect.height
            
            let window = UIApplication.shared.windows.first
            let bottomPadding = window?.safeAreaInsets.bottom ?? 0
            view.frame.origin.y -= (height - bottomPadding)
        }
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        print(#function)
        
        if let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            view.frame.origin.y = 0
        }
    }
}
