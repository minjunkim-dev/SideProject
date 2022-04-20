//
//  TvShowDetailHeaderView.swift
//  TrendMedia
//
//  Created by beneDev on 2022/04/14.
//

import UIKit

import SnapKit
import Then

final class TvShowDetailHeaderView: UIView, ViewPresentable {
    
    let backdropImageView = UIImageView()
    
    let posterImageView = UIImageView()
    
    let titleLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.textColor = .white
    }
    
    func configureView(backdropImagePath: String, imageName: String, title: String) {
        
        loadImage(imageView: backdropImageView, imagePath: backdropImagePath)
        
        let image = UIImage(named: imageName)
        posterImageView.image = image
        
        titleLabel.text = title
    }
    
    func setupView() {
        
        addSubview(backdropImageView)
        
        [
            posterImageView,
            titleLabel
        ].forEach { backdropImageView.addSubview($0) }
        
    }
    
    func setupConstraints() {
        
        backdropImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        posterImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(20)
            
            $0.width.equalToSuperview().multipliedBy(1.0 / 3)
            $0.height.equalTo(posterImageView.snp.width).multipliedBy(1.5)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(posterImageView.snp.trailing).offset(20)
            $0.bottom.equalTo(posterImageView)
            $0.trailing.equalToSuperview().inset(20)
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


