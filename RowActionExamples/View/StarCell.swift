//
//  TableViewCell.swift
//  RowActionExamples
//
//  Created by Brett Chapin on 2/19/18.
//  Copyright © 2018 Black Rose Productions. All rights reserved.
//

import UIKit

class StarCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var starImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(cellItem : (String, Bool)) {
        titleLabel.text = cellItem.0
        starImage.isHidden = !cellItem.1
    }

}
