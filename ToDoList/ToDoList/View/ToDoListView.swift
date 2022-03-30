//
//  ToDoListView.swift
//  ToDoList
//
//  Created by beneDev on 2022/03/30.
//

import UIKit

import SnapKit
import Then

final class ToDoListView: UIView, ViewPresentable {
    
    let containerView = UIView().then {
        $0.layer.cornerRadius = 10
    }
    
    let toDoTextField = UITextField().then {
        $0.placeholder = "무엇을 구매하실건가요?"
        $0.autocapitalizationType = .none
        $0.clearButtonMode = .whileEditing
    }
    
    let addButton = UIButton().then {
        $0.setTitle("추가", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.layer.cornerRadius = 10
    }
    
    let segmentControl = UISegmentedControl().then {
        
        for (index, category) in Category.allCases.enumerated() {
            $0.insertSegment(withTitle: category.description, at: index, animated: true)
        }
        
        $0.selectedSegmentTintColor = .systemGray3
        $0.tintColor = .systemGray5
        $0.selectedSegmentIndex = 0
    }
    
    func setupView() {
        backgroundColor = .white
        
        addSubview(containerView)
        containerView.backgroundColor = .systemGray5
        
        [toDoTextField, addButton].forEach {
            containerView.addSubview($0)
        }
        
        addButton.backgroundColor = .systemGray3
        
        addSubview(segmentControl)
    }
    
    func setupConstraints() {
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(20)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(UIScreen.main.bounds.height / 10)
        }
        
        addButton.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(addButton.snp.height).multipliedBy(1.5)
        }
        
        toDoTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.verticalEdges.equalTo(addButton)
            $0.trailing.equalTo(addButton.snp.leading).offset(-20)
        }
        
        segmentControl.snp.makeConstraints {
            $0.horizontalEdges.equalTo(containerView)
            $0.top.equalTo(containerView.snp.bottom).offset(20)
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
