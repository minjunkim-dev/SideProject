//
//  TvShowDescriptionView.swift
//  TrendMedia
//
//  Created by beneDev on 2022/04/11.
//

import UIKit

import SnapKit
import Then

final class TvShowDescriptionView: UIView, ViewPresentable {
    
    let containerView = UIView()
    
    let titleLabel = UILabel().then {
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.textAlignment = .left
        
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
    }
    let releaseDateLabel = UILabel().then {
        $0.textColor = .lightGray
        $0.numberOfLines = 1
        $0.textAlignment = .center
        
        $0.font = .systemFont(ofSize: 15, weight: .regular)
    }
    
    let separator = UIView().then {
        $0.backgroundColor = .black
    }
    
    let moreDetailLabel = UILabel().then {
        $0.text = "비슷한 컨텐츠 보기"
        $0.textColor = .black
        $0.numberOfLines = 1
        $0.textAlignment = .center
        
        $0.font = .systemFont(ofSize: 15, weight: .regular)
    }
    let moreDetailButton = UIButton().then {
        $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        $0.tintColor = .black
    }
    
    func setupView() {
        
        addSubview(containerView)
        
        [
            titleLabel, releaseDateLabel,
            separator,
            moreDetailLabel, moreDetailButton
        ]
            .forEach { containerView.addSubview($0) }
    }
    
    func setupConstraints() {
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
        
        releaseDateLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.equalToSuperview()
        }
        
        separator.snp.makeConstraints {
            $0.top.equalTo(releaseDateLabel.snp.bottom).offset(20)
            $0.height.equalTo(1)
            $0.horizontalEdges.equalToSuperview()
        }
    
        moreDetailLabel.snp.makeConstraints {
            $0.top.equalTo(separator.snp.bottom).offset(20)
            $0.leading.equalToSuperview()
            $0.trailing.lessThanOrEqualTo(moreDetailButton.snp.leading).offset(-20)
            $0.bottom.equalToSuperview()
        }
        
        moreDetailButton.snp.makeConstraints {
            $0.centerY.equalTo(moreDetailLabel)
            $0.trailing.equalToSuperview()
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
