//
//  SearchMediaViewController.swift
//  TrendMedia
//
//  Created by beneDev on 2022/04/13.
//

import UIKit

class SearchMediaViewController: UIViewController {

    private let mainView = SearchMediaView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
