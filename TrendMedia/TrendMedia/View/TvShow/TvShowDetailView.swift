//
//  TvShowDetailView.swift
//  TrendMedia
//
//  Created by beneDev on 2022/04/14.
//

import UIKit

import SnapKit
import Then

final class TvShowDetailView: UIView, ViewPresentable {
    
    let tableView = UITableView(frame: .zero, style: .plain).then {
        $0.separatorStyle = .singleLine
        
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = UITableView.automaticDimension
    }
    
    func setupView() {
        
        backgroundColor = .white
    
        addSubview(tableView)
        tableView.register(TvShowDetailTableViewCell.self, forCellReuseIdentifier: TvShowDetailTableViewCell.reuseIdentifier)
        tableView.register(TvShowDetailHeaderTabelViewCell.self, forCellReuseIdentifier: TvShowDetailHeaderTabelViewCell.reuseIdentifier)
        tableView.register(TvShowDetailOverviewTableViewCell.self, forCellReuseIdentifier: TvShowDetailOverviewTableViewCell.reuseIdentifier)
    }
    
    func setupConstraints() {
        
        tableView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
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


