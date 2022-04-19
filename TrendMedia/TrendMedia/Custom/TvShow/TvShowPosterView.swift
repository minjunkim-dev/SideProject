//
//  TvShowPosterView.swift
//  TrendMedia
//
//  Created by beneDev on 2022/04/11.
//

import UIKit

import SnapKit
import Then

import Kingfisher

final class TvShowPosterView: UIView, ViewPresentable {
    
    let imageView = UIImageView().then {
        $0.contentMode = .scaleToFill
    }
    
    let descriptionLabel = InsetsLabel().then {
        $0.backgroundColor = .orange
        $0.textColor = .black
        $0.numberOfLines = 1
        $0.textAlignment = .center
        $0.text = "평점"
    }
    let rateLabel = InsetsLabel().then {
        $0.backgroundColor = .white
        $0.textColor = .black
        $0.numberOfLines = 1
        $0.textAlignment = .center
    }
    
    func setupView() {
        
        addSubview(imageView)

        [
            descriptionLabel, rateLabel,
        ].forEach {
            imageView.addSubview($0)
        }
    }
    
    func setupConstraints() {
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        rateLabel.snp.makeConstraints {
            $0.leading.equalTo(descriptionLabel.snp.trailing)
            $0.centerY.equalTo(descriptionLabel)
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
