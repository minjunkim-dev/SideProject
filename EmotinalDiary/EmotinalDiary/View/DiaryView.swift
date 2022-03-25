//
//  DiaryView.swift
//  EmotinalDiary
//
//  Created by beneDev on 2022/03/25.
//

import UIKit

import SnapKit
import Then

/*
1. 즐거워 = fun
2. 기뻐 = happy
3. 사랑스러워 = lovely
4. 화나 = angry
5. 무력해 = helpless
6. 피곤해 = tired
7. 난감해 = embarrassing
8. 우울해 = depressed
9. 속상해 = upset
 */

class DiaryView: UIView, ViewPresentable {
    
    func setupView() {
        backgroundColor = .orange
    }
    
    func setupConstraints() {
        
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
