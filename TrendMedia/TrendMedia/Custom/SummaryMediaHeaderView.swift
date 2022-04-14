//
//  SummaryMediaHeaderView.swift
//  TrendMedia
//
//  Created by beneDev on 2022/04/14.
//

import UIKit

import SnapKit
import Then

final class SummaryMediaHeaderView: UIView, ViewPresentable {
    
    let containerView = UIView()
    
    let genresLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.textAlignment = .left
        
        $0.font = .systemFont(ofSize: 15, weight: .regular)
        $0.textColor = .lightGray
    }
    
    let titleLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.textAlignment = .left
        
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
        $0.textColor = .black
    }
    
    func configureView(genres: [String], title: String) {
        
        var genre = genres
        var text = "#\(genre.removeFirst())"
        genre.forEach {
            text += " #\($0)"
        }
        
        genresLabel.text = text
        titleLabel.text = title
    }
    
    func setupView() {
        
        addSubview(containerView)
        
        [genresLabel, titleLabel].forEach { containerView.addSubview($0) }
    }
    
    func setupConstraints() {
        
        containerView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.verticalEdges.equalToSuperview().inset(10)
        }
        
        genresLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(genresLabel.snp.bottom)
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

