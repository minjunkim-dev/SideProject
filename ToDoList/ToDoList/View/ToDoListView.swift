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
        $0.textColor = .black
        $0.attributedPlaceholder = NSAttributedString(
            string: "어떤 할 일이 있으신가요?",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        )
        $0.autocapitalizationType = .none
        $0.clearButtonMode = .whileEditing
    }
    
    let addButton = UIButton().then {
        $0.setTitle("추가", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 10
    }
    
    let segmentControl = UISegmentedControl().then {
        
        $0.insertSegment(withTitle: "전체", at: 0, animated: false)
        $0.selectedSegmentIndex = 0
        
        for (index, category) in Category.allCases.enumerated() {
            $0.insertSegment(withTitle: category.description, at: index + 1, animated: false)
        }
        
        $0.backgroundColor = .lightGray
        $0.selectedSegmentTintColor = .darkGray
        $0.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        $0.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
    }
    
    let tableView = UITableView(frame: .zero, style: .insetGrouped).then {
        
        /* self-sizing cell */
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = UITableView.automaticDimension
        $0.backgroundColor = .white
    }
    
    func setupView() {
        backgroundColor = .white
        
        addSubview(containerView)
        containerView.backgroundColor = .lightGray
        
        [toDoTextField, addButton].forEach {
            containerView.addSubview($0)
        }
        
        addButton.backgroundColor = .darkGray
        
        addSubview(segmentControl)
        
        addSubview(tableView)
        tableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: ToDoTableViewCell.reuseIdentifier)
    }
    
    func setupConstraints() {
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(20)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(UIScreen.main.bounds.height / 11)
        }
        
        addButton.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(10)
            $0.width.equalTo(addButton.snp.height).multipliedBy(1.5)
        }
        
        toDoTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.verticalEdges.equalTo(addButton)
            $0.trailing.equalTo(addButton.snp.leading).offset(-10)
        }
        
        segmentControl.snp.makeConstraints {
            $0.horizontalEdges.equalTo(containerView)
            $0.top.equalTo(containerView.snp.bottom).offset(20)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(segmentControl.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalTo(safeAreaLayoutGuide)
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
