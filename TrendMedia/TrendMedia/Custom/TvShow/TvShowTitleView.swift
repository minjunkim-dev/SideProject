//
//  TvShowTitleView.swift
//  TrendMedia
//
//  Created by beneDev on 2022/04/11.
//

import UIKit

import SnapKit
import Then

final class TvShowTitleView: UIView, ViewPresentable {
    
    let label = UILabel().then {
        $0.text = "OH JUN!"
        $0.textColor = .white
        $0.textAlignment = .center
        $0.numberOfLines = 1
        $0.font = .systemFont(ofSize: 40, weight: .heavy)
    }
    
    func setupView() {
        backgroundColor = .black
        
        addSubview(label)
    }
    
    func setupConstraints() {
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.edges.lessThanOrEqualToSuperview().inset(20)
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
