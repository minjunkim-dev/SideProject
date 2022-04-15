//
//  TvShowWebKitViewController.swift
//  TrendMedia
//
//  Created by beneDev on 2022/04/15.
//

import UIKit
import WebKit

class TvShowWebKitViewController: UIViewController {

    private let mainView = TvShowWebKitView()
    
    var url: String?
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = url {
            openWebPage(urlString: url)
        }
        
        mainView.webSearchBar.delegate = self
        
        mainView.navigationBar.backItem?.backBarButtonItem = UIBarButtonItem(barButtonSystemItem: .redo, target: self, action: nil)
        
        let closeButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(dismissButtonClicked))

        mainView.navigationBar.topItem?.leftBarButtonItem = closeButton
        
        let flexibleButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        let dismissButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(dismissButtonClicked))
        let backButton = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(goBackButtonClicked))
        let reloadButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadButtonClicked))
        let forwardButton = UIBarButtonItem(image: UIImage(systemName: "arrow.right"), style: .plain, target: self, action: #selector(goForwardButtonClicked))
        
        let buttons = [
            dismissButton,
            flexibleButton,
            backButton,
            flexibleButton,
            reloadButton,
            flexibleButton,
            forwardButton,
            flexibleButton,
        ]
        mainView.toolBar.items = buttons
    }
    
    @objc func goForwardButtonClicked() {
        if mainView.webView.canGoForward {
            mainView.webView.goForward()
        }
    }
    
    @objc func goBackButtonClicked() {
        if mainView.webView.canGoBack {
            mainView.webView.goBack()
        }
    }
    
    @objc func dismissButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc func reloadButtonClicked() {
        
        mainView.webView.reload()
    }
    
    func openWebPage(urlString: String) {
     
        print(urlString)
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let request = URLRequest(url: url)
        mainView.webView.load(request)
    }
}

extension TvShowWebKitViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        
        guard let text = searchBar.text else { return }
        
        var urlString = text.lowercased()
        if !(urlString.contains("www.")) {
            urlString = "www." + urlString
        }
        if !(urlString.contains("http")) {
            urlString = "http://" + urlString
        }
        
        openWebPage(urlString: urlString)
    }
}
