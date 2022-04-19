//
//  TvShowTableViewHeaderView.swift
//  TrendMedia
//
//  Created by beneDev on 2022/04/14.
//

import UIKit

import SnapKit
import Then

final class TvShowTableViewHeaderView: UIView, ViewPresentable {
    
    let containerView = UIView()
    
    let releaseDateLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.textAlignment = .left
        
        $0.font = .systemFont(ofSize: 15, weight: .regular)
        $0.textColor = .darkGray
    }
    
    let genresLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.textAlignment = .left
        
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
        $0.textColor = .black
    }
    
    func configureView(releaseDate: String, genres: [String]) {
        
        var genre = genres
        var text = "#\(genre.removeFirst())"
        genre.forEach {
            text += " #\($0)"
        }
        
        releaseDateLabel.text = releaseDate
        genresLabel.text = text
    }
    
    func setupView() {
        
        addSubview(containerView)
        
        [releaseDateLabel, genresLabel].forEach { containerView.addSubview($0) }
    }
    
    func setupConstraints() {
        
        containerView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.verticalEdges.equalToSuperview().inset(10)
        }
        
        releaseDateLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
        
        genresLabel.snp.makeConstraints {
            $0.top.equalTo(releaseDateLabel.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
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

