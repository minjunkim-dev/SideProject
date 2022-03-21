//
//  NewlyCoinedWordViewController.swift
//  NewlyCoinedWord
//
//  Created by beneDev on 2022/03/16.
//

import UIKit

import SnapKit
import Then


final class NewlyCoinedWordViewController: UIViewController {
    
    private let mainView = NewlyCoinedWordView()
    private let viewModel = NewlyCoinedWordViewModel()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
            self.mainView.hud.show(in: self.mainView, animated: true)
            self.viewModel.searchWords(query: "신조어") {
                self.mainView.hud.dismiss(animated: true)
            }
        }
        
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
            
            print(word.description)
            self.mainView.newlyCoinedWordMeaningLabel.text = word.description
        }
    }
    
    @objc private func searchTextFieldReturnKeyClicked() {
        
        guard let query = mainView.searchTextField.text, !(query.isEmpty) else {
            showAlert(title: nil, message: "텍스트를 입력해주세요", okTitle: "확인", okCompletion: nil, cancleTitle: nil, cancleCompletion: nil)
            return
        }
    
        self.mainView.hud.show(in: self.mainView, animated: true)
        self.viewModel.searchQuery(query: query) { result in
            
            if result == .failure {
                self.showAlert(title: nil, message: "신조어가 아닙니다", okTitle: "확인", okCompletion: nil, cancleTitle: nil, cancleCompletion: nil)
            }
            
            self.mainView.hud.dismiss(animated: true)
        }
    }
    
    @objc private func searchButtonClicked() {
    
        guard let query = mainView.searchTextField.text, !(query.isEmpty) else {
            showAlert(title: nil, message: "텍스트를 입력해주세요", okTitle: "확인", okCompletion: nil, cancleTitle: nil, cancleCompletion: nil)
            return
        }

        self.mainView.hud.show(in: self.mainView, animated: true)
        self.viewModel.searchQuery(query: query) { result in
            
            if result == .failure {
                self.showAlert(title: nil, message: "신조어가 아닙니다", okTitle: "확인", okCompletion: nil, cancleTitle: nil, cancleCompletion: nil)
            }
            
            self.mainView.hud.dismiss(animated: true)
        }
    
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
