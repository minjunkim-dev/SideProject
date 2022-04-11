//
//  SummaryMediaViewController.swift
//  TrendMedia
//
//  Created by beneDev on 2022/04/11.
//

import UIKit

final class SummaryMediaViewController: UIViewController {
    
    private let mainView = SummaryMediaView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
}
