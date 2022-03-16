//
//  LEDBoardView.swift
//  LEDBoard
//
//  Created by beneDev on 2022/03/15.
//

import UIKit

import SnapKit
import Then

final class LEDBoardView: UIView {
    
    let containerView = UIView().then {
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    
    let inputTextField = LEDBoardTextField()
    
    let sendTextButton = LEDBoardButton().then {
        $0.setTitle("보내기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    let changeColorButton = LEDBoardButton().then {
        $0.setTitle("Aa", for: .normal)
        let color = UIColor.init(red: UserDefaults.color[0], green: UserDefaults.color[1], blue: UserDefaults.color[2], alpha: UserDefaults.color[3])
        $0.setTitleColor(color, for: .normal)
    }
    
    lazy var boardLabel = UILabel().then {
        $0.textAlignment = .center
        
        /* 폰트 크기가 텍스트 길이에 따라 달라지게 하기 위함 */
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 200)
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.1
        $0.lineBreakMode = .byClipping
    }
    
    private func setupView() {
        backgroundColor = .black
        
        containerView.backgroundColor = .white
        addSubview(containerView)
        
        [inputTextField,
         sendTextButton, changeColorButton].forEach {
            containerView.addSubview($0)
        }
        
        addSubview(boardLabel)
        boardLabel.textColor = changeColorButton.currentTitleColor
    }
    
    private func setupConstraints() {
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(20)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(40)
            $0.height.equalTo(50)
        }
        
        inputTextField.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(sendTextButton.snp.leading)
        }
        
        changeColorButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(5)
            $0.verticalEdges.equalToSuperview().inset(5)
            $0.width.equalTo(changeColorButton.snp.height)
        }
        
        sendTextButton.snp.makeConstraints {
            $0.trailing.equalTo(changeColorButton.snp.leading).offset(-5)
            $0.verticalEdges.equalToSuperview().inset(5)
            $0.width.equalTo(sendTextButton.snp.height).multipliedBy(2)
        }
        
        boardLabel.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.bottom).offset(40)
            $0.horizontalEdges.equalTo(containerView).inset(40)
            $0.bottom.equalToSuperview().inset(40)
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
