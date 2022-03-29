//
//  AnniversaryCollectionViewCell.swift
//  AnniversaryCalculator
//
//  Created by beneDev on 2022/03/28.
//

import UIKit

final class AnniversaryCollectionViewCell: UICollectionViewCell, ViewPresentable {
    
    private let dDayLabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .center
        $0.numberOfLines = 1
        $0.font = .systemFont(ofSize: 25, weight: .heavy)
    }
    
    private let dateLabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .center
        $0.numberOfLines = 3
        $0.font = .systemFont(ofSize: 20, weight: .regular)
    }
    
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleToFill
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
    }
    
    func configureCell(data: DDay, date: Date) {
        imageView.image = data.image
//            .rotate(radians: .pi / 2)
        dDayLabel.text = "D+\(data.dday)"
        let yearString = "year".localized()
        let monthString = "month".localized()
        let dayString = "day".localized()
        let format = "yyyy\(yearString)\nM\(monthString) d\(dayString)\nEEEE"
        dateLabel.pushTransition(0.5, .fromBottom)
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
