//
//  EmotionCollectionViewCell.swift
//  EmotinalDiary
//
//  Created by beneDev on 2022/03/26.
//

import UIKit

protocol EmotionDelegate {
    func addEmotionNumber(tag: Int)
}

class EmotionCollectionViewCell: UICollectionViewCell, ViewPresentable {
    
    var delegate: EmotionDelegate?
    
    let button = UIButton().then {
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .clear
        $0.titleLabel?.numberOfLines = 1
        $0.contentMode = .scaleAspectFit
        $0.contentHorizontalAlignment = .center
        $0.contentVerticalAlignment = .center
    }
    
    let label = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .center
        $0.backgroundColor = .clear
        $0.font = .systemFont(ofSize: 15, weight: .regular)
    }
    
    let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.backgroundColor = .clear
    }
    
    func setupView() {
      
        backgroundColor = .clear
        
        contentView.addSubview(stackView)
        
        [button, label].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    func setupConstraints() {
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        label.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(0.2)
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
        
        button.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(label.snp.top)
        }
    }
    
    @objc func buttonClicked(_ sender: UIButton) {
        print(#function)
        
        let tag = self.tag
        delegate?.addEmotionNumber(tag: tag)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
        
        button.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
    }
    
}
