//
//  SearchMediaView.swift
//  TrendMedia
//
//  Created by beneDev on 2022/04/13.
//

import UIKit

import SnapKit
import Then

final class SearchMediaView: UIView, ViewPresentable {
    
    let dismissButton = UIButton().then {
        let image = UIImage(systemName: "xmark")
        $0.setImage(image, for: .normal)
        $0.tintColor = .black
    }
    
    let searchBar = UISearchBar().then {
        $0.placeholder = "텍스트를 입력해주세요"
        $0.autocapitalizationType = .none
        $0.barStyle = .default
        $0.searchBarStyle = .minimal

        $0.showsBookmarkButton = true
        $0.isSearchResultsButtonSelected = true
        $0.showsSearchResultsButton = true
        $0.enablesReturnKeyAutomatically = true
    }
    
    let tableView = UITableView(frame: .zero, style: .plain).then {
        $0.separatorStyle = .none
    }
    
    func setupView() {
    
        backgroundColor = .white
        
        [
            dismissButton, searchBar,
            tableView
        ].forEach { addSubview($0) }
        
        tableView.backgroundColor = .orange // for test
    }
    
    func setupConstraints() {
        
        dismissButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(10)
            $0.leading.equalTo(safeAreaLayoutGuide).inset(10)
            $0.size.equalTo(UIScreen.main.bounds.height * (1 / 15))
        }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(dismissButton)
            $0.height.equalTo(dismissButton)
            $0.leading.equalTo(dismissButton.snp.trailing).offset(5)
            $0.trailing.equalTo(safeAreaLayoutGuide).inset(20)
        }
        
        searchBar.searchTextField.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(10)
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

