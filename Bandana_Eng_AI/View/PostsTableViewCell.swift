//
//  PostsTableViewCell.swift
//  Bandana_Eng_AI
//
//  Created by satish pullagura on 02/02/20.
//  Copyright © 2020 Bandana. All rights reserved.
//

import UIKit

class PostsTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var switchStatus: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func updateCellOutlets(model: Posts) {
        self.titleLabel.text = model.name
        self.dateLabel.text = model.createdDate.convertdateToFormate(formate: "dd mm YYY")
        self.switchStatus.isOn = model.isOn
    }
    
}
