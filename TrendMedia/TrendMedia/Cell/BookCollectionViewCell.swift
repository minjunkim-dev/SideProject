//
//  BookCollectionViewCell.swift
//  TrendMedia
//
//  Created by beneDev on 2022/04/16.
//

import UIKit

final class BookCollectionViewCell: UICollectionViewCell, ViewPresentable {
    
    let titleLabel = UILabel().then {
        $0.textColor = .black
        $0.numberOfLines = 1
        
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
        
    }
    
    let rateLabel = UILabel().then {
        $0.textColor = .black
        $0.numberOfLines = 1
    }
    
    let posterImageView = UIImageView()
    
    func configureCell(title: String, rate: Double) {
        
        titleLabel.text = title
        rateLabel.text = "\(rate)"
        
        var imageName =
            title.lowercased()
                .replacingOccurrences(of: "'", with: "")
        imageName =
        imageName.lowercased()
                .replacingOccurrences(of: ":", with: "")
        
        imageName =
        imageName.components(separatedBy: ["&"])
            .map {
                $0.trimmingCharacters(in: [" "])
            }
            .joined(separator: " ")
        
        imageName = imageName.replacingOccurrences(of: "-", with: "_")
        
        imageName = imageName.replacingOccurrences(of: " ", with: "_")
        
        let image = UIImage(named: imageName)
        posterImageView.image = image
    }
    
    func setupView() {
        
        contentView.backgroundColor = .random
        
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        
        [
            titleLabel,
            rateLabel,
            posterImageView,
        ].forEach { contentView.addSubview($0) }
        
        posterImageView.layer.cornerRadius = 5
        posterImageView.layer.masksToBounds = true
    }
    
    func setupConstraints() {
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.horizontalEdges.equalToSuperview().inset(10)
        }
        
        rateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(20)
            $0.trailing.lessThanOrEqualTo(posterImageView.snp.leading).inset(10)
        }
        
        posterImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.trailing.equalToSuperview().inset(10)
            $0.width.equalToSuperview().multipliedBy(0.5)
            $0.height.equalTo(posterImageView.snp.width).multipliedBy(1.5)
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
