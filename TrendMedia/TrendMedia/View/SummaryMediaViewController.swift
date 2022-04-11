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
        
        let title = "TREND MEDIA"
        let font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        let leftItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .plain, target: self, action: nil)
        let rightItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: nil)
        
        configureNavigation(title: title, titleColor: .black, titleFont: font, leftItems: [leftItem], rightItems: [rightItem], barTintColor: .black)
        
    }
}
