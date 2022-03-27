//
//  DiaryView.swift
//  EmotinalDiary
//
//  Created by beneDev on 2022/03/25.
//

import UIKit

import SnapKit
import Then

class DiaryView: UIView, ViewPresentable {
    
    let imageView = UIImageView().then {
        $0.image = Assets.background.image
        $0.contentMode = .scaleToFill
    }
    
    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        
        return UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    }()
    
    func setupView() {
        backgroundColor = .clear
        
        addSubview(imageView)
        
        addSubview(collectionView)
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .clear
        collectionView.register(EmotionCollectionViewCell.self, forCellWithReuseIdentifier: EmotionCollectionViewCell.reuseIdentifier)
    }
    
    func setupConstraints() {
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        let isPortrait =
        UIApplication.shared.windows.first?.windowScene?.interfaceOrientation.isPortrait ?? false
        
        isPortrait ?
        collectionView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(40)
            $0.height.equalTo(collectionView.snp.width)
        } :
        collectionView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.verticalEdges.equalTo(safeAreaLayoutGuide)
            $0.width.equalTo(collectionView.snp.height)
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
