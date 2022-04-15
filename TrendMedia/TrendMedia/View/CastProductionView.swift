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
    
    let headerView = CastProductionHeaderView()
    
    let tableView = UITableView(frame: .zero, style: .plain).then {
        $0.separatorStyle = .singleLine
    }
    
    func setupView() {
        
        backgroundColor = .white
        
        addSubview(headerView)
        
        addSubview(tableView)
        tableView.register(CastProductionTableViewCell.self, forCellReuseIdentifier: CastProductionTableViewCell.reuseIdentifier)
    }
    
    func setupConstraints() {
        
        headerView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.height.equalToSuperview().multipliedBy(1.0 / 3)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
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


