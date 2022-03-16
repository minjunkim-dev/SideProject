//
//  newlyCoinedWordViewController.swift
//  newlyCoinedWord
//
//  Created by beneDev on 2022/03/16.
//

import UIKit

import SnapKit

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

extension newlyCoinedWordViewController {
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        
        let isPortrait = UIDevice.current.orientation.isPortrait
        isPortrait ?
        mainView.backgroundImageView.snp.remakeConstraints {
            $0.center.equalToSuperview()
            $0.horizontalEdges.equalTo(mainView.safeAreaLayoutGuide)
        } :
        mainView.backgroundImageView.snp.remakeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(1.1)
            $0.width.equalToSuperview().multipliedBy(0.5)
        }
    }
}
