//
//  SearchTvShowTableViewCell.swift
//  TrendMedia
//
//  Created by beneDev on 2022/04/13.
//

import UIKit

import SnapKit
import Then
import Kingfisher

final class SearchTvShowTableViewCell: UITableViewCell, ViewPresentable {
    
    let containerView = UIView()
    
    let mediaImageView = UIImageView().then {
        $0.contentMode = .scaleToFill
    }
    
    let titleLabel = UILabel().then {
        $0.numberOfLines = 1
        $0.textAlignment = .left
        $0.backgroundColor = .white
        
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 15, weight: .semibold)
    }
    let releaseDateAndRegionLabel = UILabel().then {
        $0.numberOfLines = 1
        $0.textAlignment = .left
        $0.backgroundColor = .white
        
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 15, weight: .medium)
    }
    let overviewLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.textAlignment = .left
        
        $0.textColor = .darkGray
        $0.font = .systemFont(ofSize: 15, weight: .regular)
    }
    
    func setupView() {
        
        selectionStyle = .none
        
        contentView.addSubview(containerView)
        containerView.backgroundColor = .white
        
        [
            mediaImageView,
            titleLabel, releaseDateAndRegionLabel,
            overviewLabel
        ].forEach { containerView.addSubview($0) }
    }
    
    func setupConstraints() {
        
        containerView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(25)
            $0.verticalEdges.equalToSuperview().inset(10)
                .priority(.low)
        }
    
        mediaImageView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.leading.equalToSuperview()
            
            $0.width.equalToSuperview().multipliedBy(0.25)
            $0.height.equalTo(mediaImageView.snp.width).multipliedBy(1.5)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(5)
            $0.leading.equalTo(mediaImageView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview()
        }
        
        releaseDateAndRegionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
                .offset(10)
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalToSuperview()
        }
        
        overviewLabel.snp.makeConstraints {
            $0.top.equalTo(releaseDateAndRegionLabel.snp.bottom)
                .offset(10)
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(5)
        }
    }
    
    func loadImage(imagePath: String) {
        let url = URL(string: imagePath)
        mediaImageView.kf.indicatorType = .activity
        mediaImageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholder_image"),
            completionHandler: { result in
                switch result {
                case .success(let value):
                    //                    dump(value)
                    print("success")
                case .failure(let error):
                    //                    dump(error)
                    print("failure")
                }
            })
    }
    
    func configureCell(title: String, releaseDate: String, region: String, overview: String, imagePath: String) {
        
        loadImage(imagePath: imagePath)
        
        titleLabel.text = title
        releaseDateAndRegionLabel.text = "\(releaseDate) | \(region)"
        overviewLabel.text = overview
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
