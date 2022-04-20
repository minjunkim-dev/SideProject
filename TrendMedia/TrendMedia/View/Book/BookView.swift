//
//  BookView.swift
//  TrendMedia
//
//  Created by beneDev on 2022/04/16.
//

import UIKit

import SnapKit
import Then

final class BookView: UIView, ViewPresentable {
    
    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()

        let inset: CGFloat = 10
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = inset
        flowLayout.minimumLineSpacing = inset
        flowLayout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        
        return UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    }()
    
    func setupView() {
       
        backgroundColor = .white
        
        addSubview(collectionView)
        collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: BookCollectionViewCell.reuseIdentifier)
    }
    
    func setupConstraints() {
        
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

