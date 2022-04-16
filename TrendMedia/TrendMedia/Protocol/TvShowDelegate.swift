//
//  TvShowDelegate.swift
//  TrendMedia
//
//  Created by beneDev on 2022/04/16.
//

import Foundation

@objc
protocol TvShowViewDelegate {
    
    @objc optional func openWebView(urlString: String)
    @objc optional func reloadCell()
}
