//
//  DiaryView.swift
//  EmotinalDiary
//
//  Created by beneDev on 2022/03/25.
//

import UIKit

import SnapKit
import Then

/*
1. 즐거워 = fun
2. 기뻐 = happy
3. 사랑스러워 = lovely
4. 화나 = angry
5. 무력해 = helpless
6. 피곤해 = tired
7. 난감해 = embarrassing
8. 우울해 = depressed
9. 속상해 = upset
 */

class DiaryView: UIView, ViewPresentable {
    
    let imageView = UIImageView().then {
        let image = UIImage(asset: Asset.background)
        $0.image = image
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
        collectionView.backgroundColor = .clear
        collectionView.register(EmotionCollectionViewCell.self, forCellWithReuseIdentifier: EmotionCollectionViewCell.reuseIdentifier)
    }
    
    func setupConstraints() {
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(40)
            $0.height.equalTo(collectionView.snp.width).multipliedBy(1.2)
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
