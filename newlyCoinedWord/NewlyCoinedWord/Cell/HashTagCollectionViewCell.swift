//
//  HashTagCollectionViewCell.swift
//  NewlyCoinedWord
//
//  Created by beneDev on 2022/03/16.
//

import UIKit

protocol HashTagDelegate {
    func searchByHashTag(query: String)
}

final class HashTagCollectionViewCell: UICollectionViewCell, ViewPresentable {
    
    var delegate: HashTagDelegate?
    
    let button = UIButton().then {
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
        
        print(#function)
        
        button.titleLabel?.numberOfLines = 1
        button.setTitle(newlyCoinedWord, for: .normal)
        
    }
    
    @objc func buttonClicked(_ sender: UIButton) {
        delegate?.searchByHashTag(query: sender.currentTitle ?? "")
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
        print(#function)
        
        setupView()
        setupConstraints()
        
        button.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
    }
}
