//
//  CastProductionViewController.swift
//  TrendMedia
//
//  Created by beneDev on 2022/04/14.
//

import UIKit

class CastProductionViewController: UIViewController {

    private let mainView = CastProductionView()
    
    var media: TvShow?
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let title = "출연/제작"
        let font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        configureNavigation(title: title, titleColor: .black, titleFont: font)
        
//        navigationController?.navigationBar.topItem?.title = "뒤로"
        
        if let media = media {
            let title = media.title
            var name =
                title.lowercased()
                    .replacingOccurrences(of: "'", with: "")
            name =
                name.lowercased()
                    .replacingOccurrences(of: ":", with: "")
            
            name =
            name.components(separatedBy: ["&"])
                .map {
                    $0.trimmingCharacters(in: [" "])
                }
                .joined(separator: " ")
            
            name = name.replacingOccurrences(of: "-", with: "_")
            
            name = name.replacingOccurrences(of: " ", with: "_")
            
            print(name)
            mainView.headerView.configureView(backdropImagePath: media.backdropImage, imageName: name, title: media.title)
        }
        
    }
}

extension CastProductionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let starring = media?.starring.components(separatedBy: ", ")
        return starring?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CastProductionTableViewCell.reuseIdentifier, for: indexPath) as? CastProductionTableViewCell else {
            return UITableViewCell()
        }
        
        let row = indexPath.row
        if let starring = media?.starring.components(separatedBy: ", ") {
            cell.configureCell(name: starring[row], role: "role", imagePath: "")
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return tableView.frame.height / 6
    }
}

extension Assets {
    
    var description: String {
        switch self {
            
        }
    }
}