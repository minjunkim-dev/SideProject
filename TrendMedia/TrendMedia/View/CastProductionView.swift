//
//  CastProductionView.swift
//  TrendMedia
//
//  Created by beneDev on 2022/04/14.
//

import UIKit

import SnapKit
import Then

final class CastProductionView: UIView, ViewPresentable {
    
    let tableView = UITableView(frame: .zero, style: .plain).then {
        $0.separatorStyle = .singleLine
        
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = UITableView.automaticDimension
    }
    
    func setupView() {
        
        backgroundColor = .white
    
        addSubview(tableView)
        tableView.register(CastProductionTableViewCell.self, forCellReuseIdentifier: CastProductionTableViewCell.reuseIdentifier)
        tableView.register(CastProductionHeaderTabelViewCell.self, forCellReuseIdentifier: CastProductionHeaderTabelViewCell.reuseIdentifier)
        tableView.register(CastProductionOverviewTableViewCell.self, forCellReuseIdentifier: CastProductionOverviewTableViewCell.reuseIdentifier)
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


