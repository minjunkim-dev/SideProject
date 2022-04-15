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
    
    let posterView = SummaryMediaPosterView()
    
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
        selectionStyle = .none
        
        contentView.layer.cornerRadius = 10
        contentView.setShadow()
        
        containerView.backgroundColor = .white // required to apply background color to properly apply shadow
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = true
        contentView.addSubview(containerView)
        
        containerView.addSubview(posterView)
        containerView.addSubview(descriptionView)
    }
    
    func setupConstraints() {
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        posterView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(UIScreen.main.bounds.height * 0.3)
            $0.horizontalEdges.equalToSuperview()
        }
        
        descriptionView.snp.makeConstraints {
            $0.top.equalTo(posterView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    func configureCell(title: String, releaseDate: String, rate: Double, imagePath: String) {
        
        var name =
            title.lowercased()
                .replacingOccurrences(of: "'", with: "")
        name =
            name.lowercased()
                .replacingOccurrences(of: ":", with: "")
        
        name =
        name.components(separatedBy: ["&"])
            .map {
                $0.trimmingCharacters(in: [" "])
            }
            .joined(separator: " ")
        
        name = name.replacingOccurrences(of: "-", with: "_")
        
        name = name.replacingOccurrences(of: " ", with: "_")
        
        posterView.imageView.image = UIImage(named: name)
        posterView.rateLabel.text = "\(rate)"
        
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
