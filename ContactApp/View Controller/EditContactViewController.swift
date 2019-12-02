//
//  EditContactViewController.swift
//  ContactApp
//
//  Created by Trung Hieu on 11/13/19.
//  Copyright © 2019 Trung Hieu. All rights reserved.
//

import UIKit

protocol SendEditedContactDelegate {
    func sendEditedContact(contact: Person)
}
class EditContactViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var contact: Person?
    var delegate: SendEditedContactDelegate?
    
    
    @IBAction func btnDoneTapped(_ sender: Any) {
        
        let cellFirstName: NameCell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! NameCell
        let cellLastName: NameCell = self.tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! NameCell
        contact?.firstName = cellFirstName.txtName.text!
        contact?.lastName = cellLastName.txtName.text!
        
        let index1 = IndexPath(row: 0, section: 1)
        let cellPhone: AddDetailCell = self.tableView.cellForRow(at: index1) as! AddDetailCell
        contact?.phoneNumber = cellPhone.txtInput.text!
       
        
        let index2 = IndexPath(row: 0, section: 2)
        let cellEmail: AddDetailCell = self.tableView.cellForRow(at: index2) as! AddDetailCell
        contact?.email = cellEmail.txtInput.text!
        
        if(delegate != nil){
            delegate?.sendEditedContact(contact: contact!)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
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
           var inSections    = [InSectionCell](arrayLiteral:InSectionCell(type: .click))
//           init(type: sectionType) {
//               self.type = type
//           }
        init(type: sectionType, numberOfRow: Int, inSection: [InSectionCell]) {
            self.type = type
            self.numberOfRow = numberOfRow
            self.inSections = inSection
        }
       }
       
       struct InSectionCell {
           var type: inSectionType?
           init(type: inSectionType) {
               self.type = type
           }
       }

    var itemName = Item(type: .name, numberOfRow: 3, inSection: [InSectionCell(type: .click)] )
    var itemPhone = Item(type: .phone, numberOfRow: 2, inSection: [InSectionCell(type: .add), InSectionCell(type: .click)])
    var itemEmail = Item(type: .email, numberOfRow: 2, inSection: [InSectionCell(type: .add), InSectionCell(type: .click)])
    var itemRingTone = Item(type: .ringtone, numberOfRow: 1, inSection: [InSectionCell(type: .click)])
    var itemTextTone = Item(type: .texttone, numberOfRow: 1, inSection: [InSectionCell(type: .click)])
    var itemUrl = Item(type: .url, numberOfRow: 1, inSection: [InSectionCell(type: .click)])
    var itemAddress = Item(type: .address, numberOfRow: 1, inSection: [InSectionCell(type: .click)])
    var itemBirthday = Item(type: .birthday, numberOfRow: 1, inSection: [InSectionCell(type: .click)])
    var itemDate = Item(type: .date, numberOfRow: 1, inSection: [InSectionCell(type: .click)])
    var itemRelateName = Item(type: .relatename, numberOfRow: 1, inSection: [InSectionCell(type: .click)])
    var itemSocialProfile = Item(type: .socialprofile, numberOfRow: 1, inSection: [InSectionCell(type: .click)])
    var itemInstantMessage = Item(type: .instantmessage, numberOfRow: 1, inSection: [InSectionCell(type: .click)])
    
    var items = [Item]()
     func initView(){
        items = [itemName, itemPhone, itemEmail, itemRingTone, itemTextTone, itemUrl, itemAddress, itemBirthday, itemDate, itemRelateName, itemSocialProfile, itemInstantMessage]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initView()
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
// MARK: - TableView
extension EditContactViewController: UITableViewDelegate{
    
}

extension EditContactViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {

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
       //let text = ["First name", "Last name", "Company"]
        
        switch item.type {
        
        case .name:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NameCell", for: indexPath) as! NameCell
            switch indexPath.row {
            case 0:
                cell.txtName.text = contact?.firstName
            case 1:
                cell.txtName.text = contact?.lastName
            default:
                cell.txtName.text = ""
            }
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
                cell.txtInput.text = contact?.phoneNumber
//                cell.btnDelete.addTarget(self, action: #selector(deleteRow), for: .allTouchEvents)
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
                cell.txtInput.text = contact?.email
                cell.btnDelete.addTarget(self, action: #selector(delete(_:)), for: .allTouchEvents)
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
    
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UISwipeActionsConfiguration?] {
//        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, indexPath) in
//            self.items[indexPath.section].inSections.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//        }
//        let deletaAction = UITableViewRowAction(style: .destructive, title: "delete") { (action, indexPath) in
//            self.items[indexPath.section].inSections.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//
//        }
//
//        return [deletaAction]
   // }
    
    //MARK: - Functions
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
    
//    @objc func deleteRow(indexPath: IndexPath){
//
//                let myAction = UIContextualAction(style: .destructive, title: "delete") { (action, sourceView, completionHandler) in
//                   self.items[indexPath.section].inSections.remove(at: indexPath.row)
//                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
//                    completionHandler(true)
//                }
//    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let myAction = UIContextualAction(style: .destructive, title: "delete") { (action, sourceView, completionHandler) in
           self.items[indexPath.section].inSections.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            completionHandler(true)
        }
        let preventSwipeFullAction = UISwipeActionsConfiguration(actions: [myAction ])
        preventSwipeFullAction.performsFirstActionWithFullSwipe = false // set false to disable full swipe action
        return preventSwipeFullAction
    }
        
    
    
}

