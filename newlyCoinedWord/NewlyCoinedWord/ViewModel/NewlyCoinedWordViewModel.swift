//
//  NewlyCoinedWordViewModel.swift
//  NewlyCoinedWord
//
//  Created by beneDev on 2022/03/16.
//

import UIKit

final class NewlyCoinedWordViewModel {
    
    var hashTagLists: [String] = ["윰차", "실매", "만만잘부", "꾸안꾸"]
    
}

extension NewlyCoinedWordViewModel: UICollectionViewCellRepresentable {
    
    var numberOfItemsInSection: Int {
        return 10
    }
    
    func cellForItemAt(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HashTagCollectionViewCell.reuseIdentifier, for: indexPath) as? HashTagCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configureCell(newlyCoinedWord: hashTagLists.randomElement()!)
        
        return cell
    }
}
