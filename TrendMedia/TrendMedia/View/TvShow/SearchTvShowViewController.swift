//
//  SearchTvShowViewController.swift
//  TrendMedia
//
//  Created by beneDev on 2022/04/13.
//

import UIKit

class SearchTvShowViewController: UIViewController {
    
    private let mainView = SearchTvShowView()
    
    var tvShowList: [TvShow] = [] {
        didSet {
            mainView.tableView.reloadData()
        }
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.searchBar.delegate = self
        
        mainView.dismissButton.addTarget(self, action: #selector(dismissButtonClicked), for: .touchUpInside)
    }
    
    @objc func dismissButtonClicked() {
        dismiss(animated: true)
    }
}

extension SearchTvShowViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tvShowList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTvShowTableViewCell.reuseIdentifier, for: indexPath) as? SearchTvShowTableViewCell else {
            return UITableViewCell()
        }
        
        let row = indexPath.row
        let title = tvShowList[row].title
        let releaseDate = tvShowList[row].releaseDate
        let region = tvShowList[row].region
        let overview = tvShowList[row].overview
        let imagePath = tvShowList[row].backdropImage
        
        cell.configureCell(title: title, releaseDate: releaseDate, region: region ,overview: overview, imagePath: imagePath)
        
        return cell
    }
}

extension SearchTvShowViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard let text = searchText.first, text != " " else {
            tvShowList = []
            return
        }
        
        tvShowList = tvShow
            .filter {
                let title = $0.title.lowercased()
                if title.contains(searchText.lowercased()) {
                    return true
                } else {
                    return false
                }
            }
    }
}

