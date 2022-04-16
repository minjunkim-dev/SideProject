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
        
    }
}

extension CastProductionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let starring = media?.starring.components(separatedBy: ", ")
        return section == 0 ? 2 : (starring?.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let (section, row) = (indexPath.section, indexPath.row)
        
        if section == 0 {
            if row == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: CastProductionHeaderTabelViewCell.reuseIdentifier, for: indexPath) as? CastProductionHeaderTabelViewCell else {
                    return UITableViewCell()
                }
                
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
                    
                    cell.headerView.configureView(backdropImagePath: media.backdropImage, imageName: name, title: media.title)
                }
                
                return cell
            } else {
                
                print("cellForRowAt: \(row)")
                guard let cell = tableView.dequeueReusableCell(withIdentifier: CastProductionOverviewTableViewCell.reuseIdentifier, for: indexPath) as? CastProductionOverviewTableViewCell else {
                    return UITableViewCell()
                }
                
                if let overview = media?.overview {
                    cell.delegate = self
                    cell.configureCell(overview: overview)
                }
                
                return cell
            }
            
        } else {
         
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CastProductionTableViewCell.reuseIdentifier, for: indexPath) as? CastProductionTableViewCell else {
                return UITableViewCell()
            }
            
            if let starring = media?.starring.components(separatedBy: ", ") {
                cell.configureCell(name: starring[row], role: "role", imagePath: "")
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let (section, row) = (indexPath.section, indexPath.row)
        
        if section == 0 {
            return row == 0 ? tableView.frame.height / 3 : UITableView.automaticDimension
        } else {
            return tableView.frame.height / 10
        }
    }
}

extension CastProductionViewController: TvShowViewDelegate {
    
    func reloadCell() {
        mainView.tableView.beginUpdates()
    
        UIView.transition(with: mainView.tableView, duration: 0.5, options: .transitionCrossDissolve) {
            self.mainView.tableView.reloadData() // 셀을 "reuse"해야만 정상동작함..
        }
        
        mainView.tableView.endUpdates()
    }
}
