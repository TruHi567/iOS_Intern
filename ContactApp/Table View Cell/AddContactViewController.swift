//
//  AddContactViewController.swift
//  ContactApp
//
//  Created by Trung Hieu on 11/6/19.
//  Copyright © 2019 Trung Hieu. All rights reserved.
//

import UIKit

class AddContactViewController: UIViewController {

    enum sectionType {
        case name
        case phone
        case addphone
        case email
        case ringtone
        case texttone
        case url
        case address
        case birthday
        case date
        case relatename
        case socialprofile
        case instantmessage
    }
    
    enum inSectionType {
        case add
        case click
    }
    
    struct Item {
        var type: sectionType
        var numberOfRow = 1
        var inSections = [InSectionCell](arrayLiteral:InSectionCell(type: .click))
        init(type: sectionType) {
            self.type = type
        }
    }
    
    struct InSectionCell {
        var type: inSectionType?
        init(type: inSectionType) {
            self.type = type
        }
    }
    var items = [Item](arrayLiteral: Item(type: .name), Item(type: .phone), Item(type: .email), Item(type: .ringtone), Item(type: .texttone), Item(type: .url), Item(type: .address), Item(type: .birthday), Item(type: .date), Item(type: .relatename), Item(type: .socialprofile), Item(type: .instantmessage))
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func btnCancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NameCell.nib, forCellReuseIdentifier: NameCell.identifier)
        tableView.register(AddPhoneCell.nib, forCellReuseIdentifier: AddPhoneCell.identifier)
        tableView.register(RingToneCell.nib, forCellReuseIdentifier: RingToneCell.identifier)
        tableView.register(AddDetailCell.nib, forCellReuseIdentifier: AddDetailCell.identifier)
    }

}

extension AddContactViewController: UITableViewDelegate{
    
}

extension AddContactViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print(items.count)
        return items.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return items.count
        if section == 0 {
            return 3
        } else {
            
            return items[section].inSections.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section]
        let text = ["First name", "Last name", "Company"]
        
        switch item.type {
        
        case .name:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NameCell", for: indexPath) as! NameCell
            cell.txtName.placeholder = text[indexPath.row]
            return cell
        case .phone:
            if item.inSections[indexPath.row].type == .click {
                let cell = tableView.dequeueReusableCell(withIdentifier: AddPhoneCell.identifier, for: indexPath) as! AddPhoneCell
                cell.nameLable.text = "add phone"
                cell.btnAdd.tag = indexPath.row
                cell.btnAdd.addTarget(self, action: #selector(addPhoneNumber), for: .touchUpInside)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: AddDetailCell.identifier, for: indexPath) as! AddDetailCell
                cell.typeLabel.text = "home"
                cell.txtInput.placeholder = "Phone"
               // cell.btnDelete.addTarget(self, action: #selector(swipeToDelete), for: .touchUpOutside)
                return cell
            }
            
        case .email:
            if item.inSections[indexPath.row].type == .click {
                let cell = tableView.dequeueReusableCell(withIdentifier: AddPhoneCell.identifier, for: indexPath) as! AddPhoneCell
                cell.nameLable?.text = "add email"
                cell.btnAdd.tag = indexPath.row
                cell.btnAdd.addTarget(self, action: #selector(addEmail), for: .touchUpInside)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: AddDetailCell.identifier, for: indexPath) as! AddDetailCell
                cell.typeLabel.text = "home"
                cell.txtInput.placeholder = "Email"
                return cell
            }
            
        case .ringtone:
            let cell = tableView.dequeueReusableCell(withIdentifier: RingToneCell.identifier, for: indexPath) as! RingToneCell
            return cell
        case .texttone:
            let cell = tableView.dequeueReusableCell(withIdentifier: RingToneCell.identifier, for: indexPath) as! RingToneCell
            cell.nameLabel.text = "Text Tone"
            return cell
        case .url:
            let cell = tableView.dequeueReusableCell(withIdentifier: AddPhoneCell.identifier, for: indexPath) as! AddPhoneCell
            cell.nameLable?.text = "add url"
            return cell
        case .address:
            let cell = tableView.dequeueReusableCell(withIdentifier: AddPhoneCell.identifier, for: indexPath) as! AddPhoneCell
            cell.nameLable?.text = "add address"
            return cell
        case .birthday:
            let cell = tableView.dequeueReusableCell(withIdentifier: AddPhoneCell.identifier, for: indexPath) as! AddPhoneCell
            cell.nameLable?.text = "add birthday"
            return cell
        case .date:
            let cell = tableView.dequeueReusableCell(withIdentifier: AddPhoneCell.identifier, for: indexPath) as! AddPhoneCell
            cell.nameLable?.text = "add date"
            return cell
        case .relatename:
            let cell = tableView.dequeueReusableCell(withIdentifier: AddPhoneCell.identifier, for: indexPath) as! AddPhoneCell
            cell.nameLable?.text = "add related name"
            return cell
        case .socialprofile:
            let cell = tableView.dequeueReusableCell(withIdentifier: AddPhoneCell.identifier, for: indexPath) as! AddPhoneCell
            cell.nameLable?.text = "add social profile"
            return cell
        case .instantmessage:
            let cell = tableView.dequeueReusableCell(withIdentifier: AddPhoneCell.identifier, for: indexPath) as! AddPhoneCell
            cell.nameLable?.text = "add instant message"
            return cell
        case .addphone:
            let cell = tableView.dequeueReusableCell(withIdentifier: AddDetailCell.identifier, for: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return nil
        }
        return " "
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let deletaAction = UITableViewRowAction(style: .destructive, title: "delete") { (action, indexPath) in
//            self.items[indexPath.section].inSections.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//
//        }
//
//        return [deletaAction]
//    }
    
    @objc func addPhoneNumber(button : UIButton){
        let indexPath = IndexPath(row: 0, section: 1)
        items[1].inSections.insert(InSectionCell(type: .add), at: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        tableView.endUpdates()
        
    }
    
    @objc func addEmail(button : UIButton){
        let indexPath = IndexPath(row: 0, section: 2)
        items[2].inSections.insert(InSectionCell(type: .add), at: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let myAction = UIContextualAction(style: .destructive, title: "delete") { (action, sourceView, completionHandler) in
           self.items[indexPath.section].inSections.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        let preventSwipeFullAction = UISwipeActionsConfiguration(actions: [myAction ])
        preventSwipeFullAction .performsFirstActionWithFullSwipe = false // set false to disable full swipe action
        return preventSwipeFullAction
    }
        
    
    
}
