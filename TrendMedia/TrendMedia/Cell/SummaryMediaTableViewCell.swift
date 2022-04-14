//
//  SummaryMediaTableViewCell.swift
//  TrendMedia
//
//  Created by beneDev on 2022/04/11.
//

import UIKit

import SnapKit
import Then

final class SummaryMediaTableViewCell: UITableViewCell, ViewPresentable {
    
    let containerView = UIView()
    
    let backdropView = SummaryMediaBackdropView()
    
    let descriptionView = SummaryMediaDescriptionView()
    
    let topInset: CGFloat = 0
    let leftInset: CGFloat = 20
    let bottomInset: CGFloat = 0
    let rightInset: CGFloat = 20
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print(#function)
        
        contentView.frame = contentView.frame.inset(by: .init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset))
    }
    
    func setupView() {
        backgroundColor = .white
    
        contentView.layer.cornerRadius = 10
        contentView.setShadow()
        
        containerView.backgroundColor = .white // required to apply background color to properly apply shadow
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = true
        contentView.addSubview(containerView)
        
        containerView.addSubview(backdropView)
        containerView.addSubview(descriptionView)
    }
    
    func setupConstraints() {
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        backdropView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(UIScreen.main.bounds.height * 0.3)
            $0.horizontalEdges.equalToSuperview()
        }
        
        descriptionView.snp.makeConstraints {
            $0.top.equalTo(backdropView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    func configureCell(title: String, releaseDate: String, rate: Double, imagePath: String) {
        
        backdropView.loadImage(imagePath: imagePath)
        backdropView.rateLabel.text = "\(rate)"
        
        descriptionView.titleLabel.text = title
        descriptionView.releaseDateLabel.text = releaseDate
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
