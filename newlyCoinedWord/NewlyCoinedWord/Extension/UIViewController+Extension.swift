//
//  UIViewController+Extension.swift
//  NewlyCoinedWord
//
//  Created by beneDev on 2022/03/18.
//

import UIKit

extension UIViewController {
    @objc func dismissKeyboard() {
        print(#function)
        
        view.endEditing(true)
    }
}
