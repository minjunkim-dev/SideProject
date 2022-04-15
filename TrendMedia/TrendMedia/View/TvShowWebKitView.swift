//
//  TvShowWebKitView.swift
//  TrendMedia
//
//  Created by beneDev on 2022/04/15.
//

import UIKit
import WebKit

import SnapKit
import Then

final class TvShowWebKitView: UIView, ViewPresentable {
    
    let navigationBar = UINavigationBar().then {
        let navItem = UINavigationItem()
        
        $0.items = [navItem]
    }
    let webSearchBar = UISearchBar().then {
        $0.autocapitalizationType = .none
    }
    let webView = WKWebView()
//    let toolBar = UIToolbar(frame: CGRect(origin: .zero, size: .init(width: UIScreen.main.bounds.width, height: 50)))
    let toolBar = UIToolbar().then {
        $0.frame = .init(origin: .zero, size: .init(width: UIScreen.main.bounds.width, height: 50))
    }
                            
    func setupView() {
        
        [
            navigationBar,
            webSearchBar,
            webView,
            toolBar,
        ].forEach { addSubview($0) }
        
    }
    
    func setupConstraints() {
        
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
        }
        
        webSearchBar.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
        }
        
        webView.snp.makeConstraints {
            $0.top.equalTo(webSearchBar.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(toolBar.snp.top)
        }
        
        toolBar.snp.makeConstraints {
            $0.top.equalTo(webView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
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
