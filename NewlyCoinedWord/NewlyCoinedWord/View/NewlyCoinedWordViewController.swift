//
//  NewlyCoinedWordViewController.swift
//  NewlyCoinedWord
//
//  Created by beneDev on 2022/03/16.
//

import UIKit

import SnapKit
import Then

extension UIView {
    func transition (_ duration: CFTimeInterval) {
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.type = .fade
        animation.subtype = .none
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.push.rawValue)
    }
}

final class NewlyCoinedWordViewController: UIViewController {
    
    let mainView = NewlyCoinedWordView()
    let viewModel = NewlyCoinedWordViewModel()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.hashTagCollectionView.delegate = self
        mainView.hashTagCollectionView.dataSource = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        mainView.searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
        mainView.searchTextField.addTarget(self, action: #selector(searchTextFieldReturnKeyClicked), for: .editingDidEndOnExit)
        
        viewModel.hashTags.bind { _ in
            
            UIView.transition(with: self.mainView.hashTagCollectionView, duration: 0.5, options: .transitionCrossDissolve) {
                self.mainView.hashTagCollectionView.reloadData()
            }
        }
        
        viewModel.searchWord.bind { word in
                
            self.mainView.newlyCoinedWordMeaningLabel.transition(1.0)
            self.mainView.newlyCoinedWordMeaningLabel.text = word.description
        
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.wordList.value = UserDefaults.wordList
        viewModel.makeHashTags()
        
        NotificationCenter.default.addObserver(self, selector: #selector(fetchWordList), name: Notification.Name("fetchWordList"), object: nil)
        NetworkManager.startMonitor()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
        NetworkManager.stopMonitor()
    }
    
    @objc private func fetchWordList() {
        print(#function)
        
        let query = "신조어"
        
        DispatchQueue.main.async {
            self.mainView.hud.textLabel.text = "리스트를 구성중입니다.\n잠시만 기다려주세요."
            self.mainView.hud.show(in: self.mainView, animated: true)
            self.viewModel.searchWords(query: query) { error in
                
                if let error = error {
                    
                    let message = error.description
        
                    self.showAlert(title: nil, message: message, okTitle: "설정", okCompletion: {
                        self.openSettings()
                    }, cancleTitle: "확인", cancleCompletion: nil)
                    
                } else {
                
                    self.viewModel.makeHashTags()
                }
            
                self.mainView.hud.dismiss(animated: true)
            }
        }
    }
    
    @objc private func searchTextFieldReturnKeyClicked() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
            self.searchButtonClicked()
        }
    }
    
    private func validateQuery() -> (String, Bool) {
        
        guard let query = mainView.searchTextField.text, !(query.isEmpty) else {
            return ("", false)
        }
        
        return (query, true)
    }
    
    @objc private func searchButtonClicked() {
    
        let (query, isValid) = validateQuery()
        if !isValid {
            self.showAlert(title: nil, message: "텍스트를 입력해주세요", okTitle: "확인", okCompletion: nil, cancleTitle: nil, cancleCompletion: nil)
            return
        }

        mainView.hud.textLabel.text = "검색중입니다"
        mainView.hud.show(in: self.mainView, animated: true)
        viewModel.searchQuery(query: query) { error in
            
            self.mainView.hud.dismiss(afterDelay: .zero, animated: true) {
                
                if let error = error {
                    let message = error.description
                    
                    if message == SearchError.isEmptyWordList.description {
                        self.showAlert(title: nil, message: message, okTitle: "설정", okCompletion: {
                            self.openSettings()
                        }, cancleTitle: "확인", cancleCompletion: nil)
                    } else {
                        self.showAlert(title: nil, message: message, okTitle: "확인", okCompletion: nil, cancleTitle: nil, cancleCompletion: nil)
                    }
                    return
                }
           
                self.viewModel.makeHashTags()
            }
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

extension NewlyCoinedWordViewController: HashTagDelegate {
    
    func searchByHashTag(query: String) {
    
        self.mainView.searchTextField.text = query
        self.searchButtonClicked()

    }
}

extension NewlyCoinedWordViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HashTagCollectionViewCell.reuseIdentifier, for: indexPath) as? HashTagCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let row = indexPath.row
        let word = viewModel.hashTags.value[row]
        cell.configureCell(newlyCoinedWord: word.title)
        cell.delegate = self
        
        return cell
    }
}
