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
        
        let title = "TREND MEDIA"
        let font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        let leftItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .plain, target: self, action: nil)
        let rightItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: nil)
        
        configureNavigation(title: title, titleColor: .black, titleFont: font, leftItems: [leftItem], rightItems: [rightItem], barTintColor: .black)
        
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
