//
//  SearchMediaViewController.swift
//  TrendMedia
//
//  Created by beneDev on 2022/04/13.
//

import UIKit

class SearchMediaViewController: UIViewController {

    private let mainView = SearchMediaView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self

        mainView.dismissButton.addTarget(self, action: #selector(dismissButtonClicked), for: .touchUpInside)
    }
    
    @objc func dismissButtonClicked() {
        
        dismiss(animated: true)
    }
}

extension SearchMediaViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tvShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchMediaTableViewCell.reuseIdentifier, for: indexPath) as? SearchMediaTableViewCell else {
            return UITableViewCell()
        }
        
        let row = indexPath.row
        let title = tvShow[row].title
        let releaseDate = tvShow[row].releaseDate
        let region = tvShow[row].region
        let overview = tvShow[row].overview
        let imagePath = tvShow[row].backdropImage
        
        cell.configureCell(title: title, releaseDate: releaseDate, region: region ,overview: overview, imagePath: imagePath)
        
        return cell
    }
}
