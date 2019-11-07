//
//  OneLineCell.swift
//  ContactApp
//
//  Created by Trung Hieu on 11/6/19.
//  Copyright © 2019 Trung Hieu. All rights reserved.
//

import UIKit

class OneLineCell: UITableViewCell {

    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    static var identifier: String {
        return String(describing: self)
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
