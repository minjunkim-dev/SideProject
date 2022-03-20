//
//  NewlyCoinedWordViewController.swift
//  NewlyCoinedWord
//
//  Created by beneDev on 2022/03/16.
//

import UIKit

import SnapKit

final class NewlyCoinedWordViewController: UIViewController {
    
    private let mainView = NewlyCoinedWordView()
    private let viewModel = NewlyCoinedWordViewModel()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.searchWords(query: "신조어")
        
        mainView.hashTagCollectionView.delegate = self
        mainView.hashTagCollectionView.dataSource = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        mainView.searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
        mainView.searchTextField.addTarget(self, action: #selector(searchTextFieldReturnKeyClicked), for: .editingDidEndOnExit)
        
        viewModel.hashTags.bind { _ in
            self.mainView.hashTagCollectionView.reloadData()
        }
        
        viewModel.searchWord.bind { word in
            
            self.mainView.newlyCoinedWordMeaningLabel.text = word.description
        }
    }
    
    @objc private func searchTextFieldReturnKeyClicked() {
        
        guard let query = mainView.searchTextField.text, !(query.isEmpty) else {
            print("텍스트가 입력이 되어 있지 않음!")
            return
        }
        
        viewModel.searchQuery(query: query, display: 1, start: 1)
    }
    
    @objc private func searchButtonClicked() {
        
        guard let query = mainView.searchTextField.text, !(query.isEmpty) else {
            print("텍스트가 입력이 되어 있지 않음!")
            return
        }
        
        viewModel.searchQuery(query: query, display: 1, start: 1)
    }
}

extension NewlyCoinedWordViewController {
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
            $0.centerY.equalToSuperview().multipliedBy(1.3)
            $0.width.equalToSuperview().multipliedBy(0.6)
        }
    }
}

extension NewlyCoinedWordViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return viewModel.cellForItemAt(collectionView, indexPath)
    }
}
