//
//  CastProductionTableViewCell.swift
//  TrendMedia
//
//  Created by beneDev on 2022/04/14.
//

import UIKit

import SnapKit
import Then

final class CastProductionTableViewCell: UITableViewCell, ViewPresentable {
    
    let containerView = UIView()
    
    let profileImageView = UIImageView().then {
        $0.contentMode = .scaleToFill
        
        $0.backgroundColor = .systemBlue // for test
        $0.layer.cornerRadius = 10
    }
    
    let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 0
        $0.distribution = .fillEqually
        $0.alignment = .leading
    }
    
    let nameLabel = UILabel().then {
        $0.textAlignment = .left
        $0.numberOfLines = 1
        
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .black
    }
    
    let roleLabel = UILabel().then {
        $0.textAlignment = .left
        $0.numberOfLines = 1
        
        $0.font = .systemFont(ofSize: 15, weight: .regular)
        $0.textColor = .darkGray
    }
    
    func setupView() {
        
        selectionStyle = .none
        
        contentView.addSubview(containerView)
        
        [
            profileImageView,
            stackView
        ].forEach { containerView.addSubview($0) }
        
        [
            nameLabel, roleLabel
        ].forEach { stackView.addArrangedSubview($0) }
    }
    
    func setupConstraints() {
        
        containerView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.verticalEdges.equalToSuperview().inset(10)
        }
        
        profileImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.verticalEdges.equalToSuperview()
            $0.width.equalTo(profileImageView.snp.height)
        }
    
        stackView.snp.makeConstraints {
            $0.centerY.equalTo(profileImageView)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview()
        }
    }
    
    func configureCell(name: String, role: String, imagePath: String) {
        
        loadImage(imagePath: imagePath)
        
        nameLabel.text = name
        roleLabel.text = role
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
    
    func loadImage(imagePath: String) {
        let url = URL(string: imagePath)
        profileImageView.kf.indicatorType = .activity
        profileImageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholder_image"),
            completionHandler: { result in
                switch result {
                case .success(let value):
                    //                    dump(value)
                    print("success")
                case .failure(let error):
                    //                    dump(error)
                    print("failure")
                }
            })
    }
}
