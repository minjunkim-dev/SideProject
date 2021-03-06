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
        
        let title = "TREND MEDIA"
        let font = UIFont.systemFont(ofSize: 18, weight: .bold)
        let leftItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .plain, target: self, action: nil)
        let rightItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchTvShowButtonClicked))
        
        configureNavigation(title: title, titleColor: .black, titleFont: font, leftItems: [leftItem], rightItems: [rightItem], barTintColor: .black)
        
        if let filmButton = mainView.mediaSelectionView.stackView.arrangedSubviews[0] as? UIButton {
            filmButton.addTarget(self, action: #selector(filmButtonClicked), for: .touchUpInside)
        }
        
        if let bookButton = mainView.mediaSelectionView.stackView.arrangedSubviews[1] as? UIButton {
            bookButton.addTarget(self, action: #selector(bookButtonClicked), for: .touchUpInside)
        }
    }
    
    @objc func filmButtonClicked() {
        let vc = FilmViewController()
        
        setNavBackButtonTitle(title: "뒤로")

        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func bookButtonClicked() {
        let vc = BookViewController()
        
        setNavBackButtonTitle(title: "뒤로")

        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func searchTvShowButtonClicked() {
        
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
        let starring = tvShow[section].starring
        let rate = tvShow[section].rate
        cell.configureCell(title: title, starring: starring, rate: rate)
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = TvShowTableViewHeaderView()
        
        let releaseDate = tvShow[section].releaseDate
        let genres = [tvShow[section].genre]
        view.configureView(releaseDate: releaseDate, genres: genres)
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = TvShowDetailViewController()
        let tvShow = tvShow[indexPath.section]
        vc.tvShow = tvShow
        
        setNavBackButtonTitle(title: "뒤로")

        navigationController?.pushViewController(vc, animated: true)
    }
}

extension TvShowViewController: TvShowViewDelegate {
    
    func openWebView(urlString: String) {
        
        let vc = TvShowWebKitViewController()
        vc.url = urlString
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .popover
        
        present(vc, animated: true)
    }
}
