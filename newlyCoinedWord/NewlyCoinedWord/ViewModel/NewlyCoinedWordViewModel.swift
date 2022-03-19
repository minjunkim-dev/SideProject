//
//  NewlyCoinedWordViewModel.swift
//  NewlyCoinedWord
//
//  Created by beneDev on 2022/03/16.
//

import UIKit

final class NewlyCoinedWordViewModel {
    
    var newlyCoinedWords: [String: String] = [
        "싫테": "싫어요(유튜브 기능) 테러의 줄임말",
        "유니콘(Unicorn) 기업": "큰 성공을 거둔 10년 이하의 스타트업 기업을 의미하는 신조어",
        "슬세권": "\'슬리퍼로 생활 가능한 세력권\'의 줄임말",
        "갑통알": "\'갑자기 통장을 보니 알바해야겠다\'의 줄임말로 통장 잔고가 얼마 남지 않았을 때를 의미함",
    ]
}

extension NewlyCoinedWordViewModel: UICollectionViewCellRepresentable {
    
    var numberOfItemsInSection: Int {
        return 10
    }
    
    func cellForItemAt(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HashTagCollectionViewCell.reuseIdentifier, for: indexPath) as? HashTagCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configureCell(newlyCoinedWord: newlyCoinedWords.keys.randomElement()!)
        
        return cell
    }
}
