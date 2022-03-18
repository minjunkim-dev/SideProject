//
//  HashTagCollectionViewCell.swift
//  NewlyCoinedWord
//
//  Created by beneDev on 2022/03/16.
//

import UIKit

class HashTagCollectionViewCell: UICollectionViewCell, ViewPresentable {
    
    let button = UIButton().then {
        $0.titleLabel?.numberOfLines = 1
        $0.setTitleColor(.black, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.cornerRadius = 10
        
        if #available(iOS 15.0, *) {
            var config = UIButton.Configuration.plain()
            config.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
            $0.configuration = config
        } else {
            $0.contentEdgeInsets = .init(top: 5, left: 10, bottom: 5, right: 10)
        }
    }
    
    func configureCell(newlyCoinedWord: String) {
        button.setTitle(newlyCoinedWord, for: .normal)
    }
    
    func setupView() {
        
        backgroundColor = .white
        
        contentView.addSubview(button)
    }
    
    func setupConstraints() {
        
        button.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
}
