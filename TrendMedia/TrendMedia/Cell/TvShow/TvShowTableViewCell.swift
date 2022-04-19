//
//  TvShowTableViewCell.swift
//  TrendMedia
//
//  Created by beneDev on 2022/04/11.
//

import UIKit

import SnapKit
import Then

final class TvShowTableViewCell: UITableViewCell, ViewPresentable {
    
    var delegate: TvShowViewDelegate?
    
    let containerView = UIView()
    
    let posterView = TvShowPosterView()
    
    let descriptionView = TvShowDescriptionView()
    
    let linkButton = UIButton().then {
        $0.tintColor = .white
        
        let image = UIImage(systemName: "link.circle.fill")
        $0.setImage(image, for: .normal)
        $0.setPreferredSymbolConfiguration(.init(pointSize: 35), forImageIn: .normal)
    }
    
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
        containerView.addSubview(linkButton)
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
        
        linkButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
        }
    }
    
    func configureCell(title: String, starring: String, rate: Double) {
        
        let name = title.convertToResourceName()
        posterView.imageView.image = UIImage(named: name)
        posterView.rateLabel.text = "\(rate)"
        
        descriptionView.titleLabel.text = title
        descriptionView.starringLabel.text = starring
    }
    
    @objc func linkButtonClicked() {
        print(#function)
        
        let urlString = "https://www.themoviedb.org"
        
        delegate?.openWebView?(urlString: urlString)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupConstraints()
        
        linkButton.addTarget(self, action: #selector(linkButtonClicked), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
