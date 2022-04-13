//
//  SummaryMediaSelectionView.swift
//  TrendMedia
//
//  Created by beneDev on 2022/04/11.
//

import UIKit

import SnapKit
import Then

final class SummaryMediaSelectionView: UIView, ViewPresentable {
    
    private let stackView = UIStackView().then {
        $0.distribution = .equalSpacing
        $0.axis = .horizontal
    }
    
    private let buttonImageName = [
        "film",
        "tv",
        "book.closed",
    ]
    
    private let buttonTintColor = [
        UIColor.green,
        UIColor.systemYellow,
        UIColor.systemBlue,
    ]
    
    private func getMediaButton(imageName: String, tintColor: UIColor) -> UIButton {
        let button = UIButton()
        let image = UIImage(systemName: imageName)
        button.setImage(image, for: .normal)
        button.tintColor = tintColor
        button.setPreferredSymbolConfiguration(.init(pointSize: 40), forImageIn: .normal)
        
        return button
    }
    
    func setupView() {
        backgroundColor = .white
        
        addSubview(stackView)

        buttonImageName.enumerated().forEach { (index, imageName) in
            let tintColor = buttonTintColor[index]
            
            let button = getMediaButton(imageName: imageName, tintColor: tintColor)
            stackView.addArrangedSubview(button)
        }
    }
    
    func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(40)
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
