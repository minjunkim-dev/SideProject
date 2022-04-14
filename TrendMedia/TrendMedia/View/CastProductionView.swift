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
    }
    
    func setupView() {
        
        addSubview(tableView)
    }
    
    func setupConstraints() {
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
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


