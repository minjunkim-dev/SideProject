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
}
