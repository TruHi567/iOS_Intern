//
//  AddContactViewController.swift
//  ContactApp
//
//  Created by Trung Hieu on 11/6/19.
//  Copyright © 2019 Trung Hieu. All rights reserved.
//

import UIKit
protocol AddContactDelegate: class {
    func addContact(person: Person)
}
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
    
    var delegate: AddContactDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func btnCancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
   
    @IBAction func btnDonetapped(_ sender: Any) {
        
        let cellFirstName: NameCell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! NameCell
        let cellLastName: NameCell = self.tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! NameCell
        let name = cellFirstName.txtName.text! + " " + cellLastName.txtName.text!
        print(name)
        let index1 = IndexPath(row: 0, section: 1)
        let cellPhone: AddDetailCell = self.tableView.cellForRow(at: index1) as! AddDetailCell
        let phoneNumber = cellPhone.txtInput.text!
        print(phoneNumber)
        
        let index2 = IndexPath(row: 0, section: 2)
        let cellEmail: AddDetailCell = self.tableView.cellForRow(at: index2) as! AddDetailCell
        let email = cellEmail.txtInput.text!
        print(email)
        
        let person = Person(firstName: cellFirstName.txtName.text!, lastName: cellLastName.txtName.text!, phoneNumber: cellPhone.txtInput.text, email: cellEmail.txtInput.text)
        
        print("Inited")
        
        
        if delegate != nil {
            delegate?.addContact(person: person)
            print("Send!")
        }
        addData(person: person)
        self.dismiss(animated: true, completion: nil)
    }
    
    func addData(person: Person){
        let contactEncoder = JSONEncoder()
        let contactDecoder = JSONDecoder()
        contactEncoder.outputFormatting = .prettyPrinted
        
        do{
            let fileUrl = try FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("data1.json")
            
            let contactJSONData = try contactEncoder.encode([person])
                       
            if let jsonString = String(data: contactJSONData, encoding: .utf8){
                print(jsonString)
            }
            
            try contactJSONData.write(to: fileUrl)
            
            let data = try Data(contentsOf: fileUrl)
            let dataContact = try contactDecoder.decode([Person].self, from: data)
            for contact in dataContact {
                print(contact.firstName)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NameCell.nib, forCellReuseIdentifier: NameCell.identifier)
        tableView.register(AddPhoneCell.nib, forCellReuseIdentifier: AddPhoneCell.identifier)
        tableView.register(RingToneCell.nib, forCellReuseIdentifier: RingToneCell.identifier)
        tableView.register(AddDetailCell.nib, forCellReuseIdentifier: AddDetailCell.identifier)
    }

}
// MARK: Table View

extension AddContactViewController: UITableViewDelegate{
    
}

extension AddContactViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
                cell.btnDelete.addTarget(self, action: #selector(deleteRow), for: .allTouchEvents)
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
    
    @objc func deleteRow(indexPath: IndexPath){

        let myAction = UIContextualAction(style: .destructive, title: "delete") { (action, sourceView, completionHandler) in
        self.items[indexPath.section].inSections.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
        completionHandler(true)
                }
    }
    
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

