//
//  LEDBoardViewModel.swift
//  LEDBoard
//
//  Created by beneDev on 2022/03/15.
//

import Foundation

final class LEDBoardViewModel {
    
    var text: Observable<String> = Observable(UserDefaults.text)
}
