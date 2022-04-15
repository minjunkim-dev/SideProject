//
//  TvShowViewController.swift
//  TrendMedia
//
//  Created by beneDev on 2022/04/11.
//

import UIKit

final class TvShowViewController: UIViewController {
    
    private let mainView = TvShowView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.mediaTableView.delegate = self
        mainView.mediaTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let title = "TREND MEDIA"
        let font = UIFont.systemFont(ofSize: 18, weight: .bold)
        let leftItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .plain, target: self, action: nil)
        let rightItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchMediaButtonClicked))
        
        configureNavigation(title: title, titleColor: .black, titleFont: font, leftItems: [leftItem], rightItems: [rightItem], barTintColor: .black)
    }
    
    @objc func searchMediaButtonClicked() {
        
        let vc = SearchTvShowViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .coverVertical
        present(vc, animated: true)
    }
}

extension TvShowViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tvShow.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TvShowTableViewCell.reuseIdentifier, for: indexPath) as? TvShowTableViewCell else { return UITableViewCell() }
        
        let section = indexPath.section
        
        let title = tvShow[section].title
        let releaseDate = tvShow[section].releaseDate
        let rate = tvShow[section].rate
        let imagePath = tvShow[section].backdropImage
        cell.configureCell(title: title, releaseDate: releaseDate, rate: rate, imagePath: imagePath)
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = TvShowTableViewHeaderView()
        
        let genres = [tvShow[section].genre]
        let title = tvShow[section].title
        view.configureView(genres: genres, title: title)
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = CastProductionViewController()
        let media = tvShow[indexPath.section]
        vc.media = media
        
        let title = "뒤로"
        let backBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .black
        navigationItem.backBarButtonItem = backBarButtonItem

        navigationController?.pushViewController(vc, animated: true)
    }
}

extension TvShowViewController: TvShowViewDelegate {
    
    func linkButtonClicked(urlString: String) {
        
        let vc = TvShowWebKitViewController()
        vc.url = urlString
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .popover
        
        present(vc, animated: true)
    }
}
