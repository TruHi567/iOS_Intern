//
//  EditContactViewController.swift
//  ContactApp
//
//  Created by Trung Hieu on 11/13/19.
//  Copyright © 2019 Trung Hieu. All rights reserved.
//

import UIKit

class EditContact1ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var contact: Person?
    
    @IBAction func btnDoneClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension EditContact1ViewController: UITableViewDelegate{
    
}

extension EditContact1ViewController: UITableViewDataSource{
    
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
                cell.txtInput.placeholder = "Phone"
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
                cell.txtInput.placeholder = "Email"
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

