//
//  SettingTableViewCell.swift
//  PracticeTableViewController
//
//  Created by beneDev on 2022/03/30.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    static let identifier = String(describing: SettingTableViewCell.self)
    
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(content: String) {
        label.text = content
    }
}
