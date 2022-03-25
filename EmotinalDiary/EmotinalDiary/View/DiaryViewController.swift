//
//  DiaryViewController.swift
//  EmotinalDiary
//
//  Created by beneDev on 2022/03/25.
//

import UIKit

class DiaryViewController: UIViewController {
    
    private let mainView = DiaryView()

    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
