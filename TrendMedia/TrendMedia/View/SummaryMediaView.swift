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
    
    let mediaTableView = UITableView(frame: .zero, style: .grouped).then {
        $0.separatorStyle = .none
        
        /* self-sizing cell */
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = UITableView.automaticDimension
        
        $0.sectionFooterHeight = .leastNonzeroMagnitude
    }
    
    func setupView() {
        backgroundColor = .white
        
        addSubview(titleView)
        
        addSubview(mediaSelectionView)
        mediaSelectionView.layer.cornerRadius = 10
        mediaSelectionView.setShadow()
        
        addSubview(mediaTableView)
        mediaTableView.register(SummaryMediaTableViewCell.self, forCellReuseIdentifier: SummaryMediaTableViewCell.reuseIdentifier)
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
        
        mediaTableView.snp.makeConstraints {
            $0.top.equalTo(mediaSelectionView.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalTo(safeAreaLayoutGuide)
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

