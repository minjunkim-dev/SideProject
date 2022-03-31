//
//  ToDoTableViewCell.swift
//  ToDoList
//
//  Created by beneDev on 2022/03/30.
//

import UIKit

import SnapKit
import Then

final class ToDoTableViewCell: UITableViewCell, ViewPresentable {

    let checkButton = UIButton().then {
        $0.tintColor = .black
        $0.setPreferredSymbolConfiguration(.init(pointSize: 20), forImageIn: .normal)
    }
    
    let contentLabel = UILabel().then {
        $0.textColor = .black
        $0.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(data: ToDo) {
        
        checkButton.isSelected = data.isCompleted
        let image = checkButton.isSelected ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "checkmark.square")
        checkButton.setImage(image, for: .normal)
        contentLabel.text = data.content
    }
    
    func setupView() {
        
        [checkButton, contentLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    func setupConstraints() {
        
        checkButton.snp.makeConstraints {
            $0.centerY.equalTo(contentLabel)
            $0.leading.equalToSuperview().inset(20)
        }
        
        contentLabel.snp.makeConstraints {
            $0.leading.equalTo(checkButton.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.verticalEdges.equalToSuperview().inset(10)
        }
    }
    
    @objc private func checkButtonClicked(_ sender: UIButton) {
        
        sender.isSelected.toggle()
        
        let image = sender.isSelected ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "checkmark.square")
        sender.setImage(image, for: .normal)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupConstraints()
        
        checkButton.addTarget(self, action: #selector(checkButtonClicked(_:)), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
