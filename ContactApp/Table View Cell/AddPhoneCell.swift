//
//  AddPhoneCell.swift
//  ContactApp
//
//  Created by Trung Hieu on 11/6/19.
//  Copyright © 2019 Trung Hieu. All rights reserved.
//

import UIKit

protocol AddButtonCellDelegate: class {
    func cell(cell: UITableViewCell?, touchButtonAt indexPath: IndexPath?)
}
class AddPhoneCell: UITableViewCell {
    
    private var indexPath: IndexPath?

    @IBOutlet weak var btnAdd: UIButton!
    
    @IBOutlet weak var nameLable: UILabel!
    
    weak var delegate : AddButtonCellDelegate?
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: Functions
    func configView(object: AnyObject?, at indexPath: IndexPath?) {
        self.indexPath = indexPath
    }
    
    // MARK: IBAction
    @IBAction fileprivate  func touchButtonAddAction(sender: UIButton? ) {
        delegate?.cell(cell: self, touchButtonAt: indexPath)
    }
    
}
