//
//  FilmViewController.swift
//  TrendMedia
//
//  Created by beneDev on 2022/04/16.
//

import UIKit

final class FilmViewController: UIViewController {

    private let mainView = FilmView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title = "영화"
        let font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        let filterItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: nil)
        configureNavigation(title: title, titleColor: .black, titleFont: font, rightItems: [filterItem], barTintColor: .black)
    }
}
