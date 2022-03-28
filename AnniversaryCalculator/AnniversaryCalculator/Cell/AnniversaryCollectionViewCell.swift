//
//  AnniversaryCollectionViewCell.swift
//  AnniversaryCalculator
//
//  Created by beneDev on 2022/03/28.
//

import UIKit

class AnniversaryCollectionViewCell: UICollectionViewCell, ViewPresentable {
    
    let dDayLabel = UILabel().then {
        $0.textColor = .white
        $0.textAlignment = .center
        $0.numberOfLines = 1
    }
    
    let dateLabel = UILabel().then {
        $0.textColor = .white
        $0.textAlignment = .center
        $0.numberOfLines = 3
    }
    
    let imageView = UIImageView().then {
        $0.contentMode = .scaleToFill
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
    }
    
    func configureCell(dDay: Int, date: Date, image: UIImage) {
        imageView.image = image
        dDayLabel.text = "D+\(dDay)"
        let format = "yyyy년\nM월 d일\nEEEE"
        dateLabel.text = date.convertToString(format: format)
    }
    
    func setupView() {
        
        contentView.addSubview(imageView)
        
        [dDayLabel, dateLabel].forEach {
            imageView.addSubview($0)
        }
    }
    
    func setupConstraints() {
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        dDayLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.lessThanOrEqualToSuperview().inset(10)
        }
        
        dateLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.horizontalEdges.lessThanOrEqualToSuperview().inset(10)
            $0.bottom.lessThanOrEqualToSuperview().inset(10)
            $0.top.greaterThanOrEqualTo(dDayLabel.snp.bottom)
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
