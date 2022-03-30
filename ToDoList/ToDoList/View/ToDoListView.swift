//
//  ToDoListView.swift
//  ToDoList
//
//  Created by beneDev on 2022/03/30.
//

import UIKit

final class ToDoListView: UIView, ViewPresentable {
    
    func setupView() {
        backgroundColor = .white
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
