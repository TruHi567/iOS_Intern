//
//  AddContact.swift
//  ContactApp
//
//  Created by Trung Hieu on 10/31/19.
//  Copyright © 2019 Trung Hieu. All rights reserved.
//

import Foundation
import UIKit

class AddContact: UITableViewController{
    
    
    
    @IBOutlet var tblInfor: UITableView!
    
    @IBAction func addPhone(_ sender: Any) {
        tblInfor.insertRows(at: [IndexPath(row: 1, section: 2)], with: .top)
    }
    
    @IBOutlet var inforTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnCancelClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
   
    
    
    
}
