//
//  DrinkWaterView.swift
//  DrinkWater
//
//  Created by beneDev on 2022/04/04.
//

import UIKit

import Lottie
import SnapKit
import Then

final class DrinkWaterView: UIView, ViewPrenstable {
        
    let animationView = AnimationView(name: "cactus").then {
        $0.contentMode = .scaleAspectFit
    }
    
    let label = UILabel()
    
    func setupView() {
    
        
        addSubview(label)
        label.text = "아아아 테스트입니다!"
        label.font = .systemFont(ofSize: 50)
    }
    
    func setupConstraints() {
        
        label.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemGreen
        addSubview(animationView)
        animationView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        animationView.play{ _ in
            self.animationView.removeFromSuperview()
            
            self.setupView()
            self.setupConstraints()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
