//
//  BookViewController.swift
//  TrendMedia
//
//  Created by beneDev on 2022/04/16.
//

import UIKit

final class BookViewController: UIViewController {

    private let mainView = BookView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
        let title = "도서"
        let font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        configureNavigation(title: title, titleColor: .black, titleFont: font)
    }
}

extension BookViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return tvShow.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.reuseIdentifier, for: indexPath) as? BookCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let row = indexPath.row
        let info = tvShow[row]
        cell.configureCell(title: info.title, rate: info.rate)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize()
        }
    
        /* scroll이 vertical 방향이고,
         vertical 방향으로는 셀의 수가 유동적이기 때문에,
         width를 먼저 결정하고 정사각형 크기를 위해
         height을 width와 동일하게 설정함
         */
        let minimumInteritemSpacingForSectionAt = flowLayout.minimumInteritemSpacing
        
        let width = collectionView.frame.width - (flowLayout.sectionInset.left + flowLayout.sectionInset.right)
        
        let cellInRow = 2
        let cellWidth = (width - minimumInteritemSpacingForSectionAt) / CGFloat(cellInRow)
        
        return CGSize(width: cellWidth, height: cellWidth)
    }
}
