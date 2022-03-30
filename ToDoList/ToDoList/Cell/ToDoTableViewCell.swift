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

    let contentLabel = UILabel().then {
        $0.textColor = .black
        $0.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(content: String) {
        
        contentLabel.text = content
    }
    
    func setupView() {
        contentView.addSubview(contentLabel)
    }
    
    func setupConstraints() {
        
        contentLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.verticalEdges.equalToSuperview().inset(10)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
