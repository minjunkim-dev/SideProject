//
//  CastProductionHeaderTabelViewCell.swift
//  TrendMedia
//
//  Created by beneDev on 2022/04/16.
//

import UIKit

import SnapKit
import Then

final class CastProductionHeaderTabelViewCell: UITableViewCell, ViewPresentable {
    
    let headerView = CastProductionHeaderView()

    func setupView() {
        
        selectionStyle = .none
        
        contentView.addSubview(headerView)
    }
    
    func setupConstraints() {
        
        headerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        print(reuseIdentifier)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
