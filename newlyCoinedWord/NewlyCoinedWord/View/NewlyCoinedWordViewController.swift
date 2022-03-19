//
//  NewlyCoinedWordViewController.swift
//  NewlyCoinedWord
//
//  Created by beneDev on 2022/03/16.
//

import UIKit

import SnapKit

import Alamofire
import SwiftSoup

final class NewlyCoinedWordViewController: UIViewController {
    
    private let mainView = NewlyCoinedWordView()
    private let viewModel = NewlyCoinedWordViewModel()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.hashTagCollectionView.delegate = self
        mainView.hashTagCollectionView.dataSource = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
      
        
        let query = "(신조어)"
        let endpoint = Endpoint.searchEncyc(query: query, display: 100, start: 1)
        let url = endpoint.url
        AF.request(url, method: .get, parameters: endpoint.parameter, encoding: URLEncoding.queryString, headers: APIDefault.header)
            .validate(statusCode: 200..<400)
            .responseDecodable(of: SearchResult.self) { response in
                
                switch response.result {
                case .success(let result):
                    print(result)
                case .failure(let error):
                    print(error)
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

extension NewlyCoinedWordViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return viewModel.cellForItemAt(collectionView, indexPath)
    }
}
