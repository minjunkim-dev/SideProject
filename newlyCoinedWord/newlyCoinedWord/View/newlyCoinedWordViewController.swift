//
//  newlyCoinedWordViewController.swift
//  newlyCoinedWord
//
//  Created by beneDev on 2022/03/16.
//

import UIKit

final class newlyCoinedWordViewController: UIViewController {
    
    private let mainView = newlyCoinedWordView()
    private let viewModel = newlyCoinedWordViewModel()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}
