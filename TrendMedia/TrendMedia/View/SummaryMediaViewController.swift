//
//  SummaryMediaViewController.swift
//  TrendMedia
//
//  Created by beneDev on 2022/04/11.
//

import UIKit

final class SummaryMediaViewController: UIViewController {
    
    private let mainView = SummaryMediaView()
    
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
        
        let vc = SearchMediaViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .coverVertical
        present(vc, animated: true)
    }
}

extension SummaryMediaViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tvShow.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SummaryMediaTableViewCell.reuseIdentifier, for: indexPath) as? SummaryMediaTableViewCell else { return UITableViewCell() }
        
        let section = indexPath.section
        
        let title = tvShow[section].title
        let releaseDate = tvShow[section].releaseDate
        let rate = tvShow[section].rate
        let imagePath = tvShow[section].backdropImage
        cell.configureCell(title: title, releaseDate: releaseDate, rate: rate, imagePath: imagePath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = SummaryMediaHeaderView()
        
        let genres = [tvShow[section].genre]
        let title = tvShow[section].title
        view.configureView(genres: genres, title: title)
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = CastProductionViewController()
        
        let title = "뒤로"
        let backBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .black
        navigationItem.backBarButtonItem = backBarButtonItem

        navigationController?.pushViewController(vc, animated: true)
    }
}
