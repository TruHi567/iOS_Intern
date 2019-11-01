//
//  GroupsTableViewController.swift
//  ContactApp
//
//  Created by Trung Hieu on 11/1/19.
//  Copyright © 2019 Trung Hieu. All rights reserved.
//

import Foundation
import UIKit

class GroupsTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func btnDoneClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.backgroundColor = .blue
    }
}
