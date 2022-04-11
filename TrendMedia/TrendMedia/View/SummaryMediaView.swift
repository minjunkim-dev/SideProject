//
//  SummaryMediaView.swift
//  TrendMedia
//
//  Created by beneDev on 2022/04/11.
//

import UIKit

import SnapKit
import Then

final class SummaryMediaView: UIView, ViewPresentable {
    
    let titleView = SummaryMediaTitleView()
    
    let mediaSelectionView = SummaryMediaSelectionView()
    
//    let mediaTableView = UITableView.then {
//
//    }
    
    func setupView() {
        backgroundColor = .white
        
        addSubview(titleView)
        
        addSubview(mediaSelectionView)
        mediaSelectionView.setShadow()
    }
    
    func setupConstraints() {
        
        titleView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(1.0 / 8)
        }
        
        mediaSelectionView.snp.makeConstraints {
            $0.top.equalTo(titleView.label.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalToSuperview().multipliedBy(1.0 / 7)
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

