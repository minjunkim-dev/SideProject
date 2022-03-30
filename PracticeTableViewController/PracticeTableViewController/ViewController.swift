//
//  ViewController.swift
//  PracticeTableViewController
//
//  Created by beneDev on 2022/03/29.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    
    var sections: [Section] = [
        Section(header: "전체 설정", content: ["공지사항", "실험실", "버전 정보"], footer: nil),
        Section(header: "개인 설정", content: ["개인/보안", "알림", "채팅", "멀티프로필"], footer: nil),
        Section(header: "기타", content: ["고객센터/도움말"], footer: nil)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationBar.topItem?.title = "설정"
        
        let nibName = UINib(nibName: "SettingTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: SettingTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self

    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print(#function)
        print(sections.count)
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        print(sections[section].content.count)
        return sections[section].content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as? SettingTableViewCell else {
            return UITableViewCell()
        }
        
        let section = indexPath.section
        let row = indexPath.row
        let content = sections[section].content[row]
        cell.configureCell(content: content)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].header
    }
}
