//
//  UIViewController+Extension.swift
//  LEDBoard
//
//  Created by beneDev on 2022/03/15.
//

import UIKit

extension UIViewController {
    @objc func dismissKeyboard() {
        print(#function)
        
        view.endEditing(true)
    }
}
