//
//  TvShowDetailOverviewTableViewCell.swift
//  TrendMedia
//
//  Created by beneDev on 2022/04/16.
//

import UIKit

import SnapKit
import Then

final class TvShowDetailOverviewTableViewCell: UITableViewCell, ViewPresentable {
    
    var delegate: TvShowViewDelegate?
    
    let containerView = UIView()
    
    let overviewLabel = UILabel().then {
        $0.textColor = .black
        
        $0.numberOfLines = 3
    }
    
    let expandableButton = UIButton().then {
        $0.tintColor = .black
        
        let image = UIImage(systemName: "chevron.down")
        $0.setImage(image, for: .normal)
        $0.isSelected = false
    }
    
    func setupView() {
        
        selectionStyle = .none
        
        contentView.addSubview(containerView)
        
        [
            overviewLabel,
            expandableButton,
        ].forEach { containerView.addSubview($0) }
    }
    
    func setupConstraints() {
        
        containerView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.verticalEdges.equalToSuperview().inset(10)
        }
        
        overviewLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
        
        expandableButton.snp.makeConstraints {
            $0.top.equalTo(overviewLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(containerView)
        }
    }
    
    func configureCell(overview: String) {
        
        overviewLabel.text = overview
    }
    
    func configureExpandableView() {
        
        if expandableButton.isSelected {
            let image = UIImage(systemName: "chevron.up")
            expandableButton.setImage(image, for: .normal)
            overviewLabel.numberOfLines = 0
        } else {
            let image = UIImage(systemName: "chevron.down")
            expandableButton.setImage(image, for: .normal)
            overviewLabel.numberOfLines = 3
        }
    }
    
    @objc func expandableButtonClicked() {
        
        expandableButton.isSelected.toggle()
        configureExpandableView()
        
        delegate?.reloadCell?()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        print(reuseIdentifier)
        
        setupView()
        setupConstraints()
        
        expandableButton.addTarget(self, action: #selector(expandableButtonClicked), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
}
