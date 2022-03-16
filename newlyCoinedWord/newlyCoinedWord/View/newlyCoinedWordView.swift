//
//  newlyCoinedWordView.swift
//  newlyCoinedWord
//
//  Created by beneDev on 2022/03/16.
//

import UIKit

import SnapKit
import Then

final class newlyCoinedWordView: UIView {
    
    let searchButton = UIButton().then {
        
        let image = UIImage(systemName: "magnifyingglass")
        $0.setImage(image, for: .normal)
        $0.tintColor = .white
        $0.setPreferredSymbolConfiguration(.init(pointSize: 25), forImageIn: .normal)
        $0.backgroundColor = .black
    }
    
    let searchTextField = InsetsTextField().then {
        $0.attributedPlaceholder = NSAttributedString(
            string: "신조어를 입력해주세요",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        $0.textColor = .black
        $0.autocapitalizationType = .none
    }
    
    lazy var searchStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 0
        $0.distribution = .equalSpacing
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 2
    }
    
    let backgroundImageView = UIImageView().then {
        let image = UIImage(named: "background")
        $0.image = image
        $0.contentMode = .scaleAspectFill
    }
    
    let newlyCoinedWordMeaningLabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .center
        $0.numberOfLines = 4
        $0.font = .systemFont(ofSize: 20, weight: .heavy)
        $0.lineBreakMode = .byClipping
    }
    
    private func setupView() {
        backgroundColor = .white
        
        addSubview(backgroundImageView)
        
        backgroundImageView.addSubview(newlyCoinedWordMeaningLabel)
        
        
        newlyCoinedWordMeaningLabel.text = """
        신조어 단어의 뜻 더미더미 신조어 단어의 뜻 더미더미 신조어 단어의 뜻 더미더미 신조어 단어의 뜻 더미더미 신조어 단어의 뜻 더미더미 신조어 단어의 뜻 더미더미 신조어 단어의 뜻 더미더미 신조어 단어의 뜻 더미더미 신조어 단어의 뜻 더미더미 신조어 단어의 뜻 더미더미 신조어 단어의 뜻 더미더미 신조어 단어의 뜻 더미더미 신조어 단어의 뜻 더미더미 신조어 단어의 뜻 더미더미 신조어 단어의 뜻 더미더미
        """
        
        addSubview(searchStackView)
        
        [searchTextField, searchButton].forEach {
            searchStackView.addArrangedSubview($0)
        }
        
    }
    
    private func setupConstraints() {
        
        searchStackView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(50)
        }
        
        searchButton.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.width.equalTo(searchButton.snp.height)
        }
        
        searchTextField.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        let isPortrait = UIDevice.current.orientation.isPortrait
        isPortrait ?
        backgroundImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide)
        } :
        backgroundImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(1.1)
            $0.width.equalToSuperview().multipliedBy(0.5)
        }
        
        backgroundImageView.backgroundColor = .systemOrange
        
        newlyCoinedWordMeaningLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(40)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
}
