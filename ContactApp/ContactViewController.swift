//
//  ContactViewController.swift
//  ContactApp
//
//  Created by Trung Hieu on 10/29/19.
//  Copyright © 2019 Trung Hieu. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController, selectedContactDelegate{
    
    enum contactSectionType{
        case phone
        case email
        case address
        case birthday
        case note
        case sendMessage
        case shareContact
    }
    var itemsContact = [contactSectionType](arrayLiteral: .phone, .email, .address, .birthday, .note, .sendMessage, .shareContact)
 
    var delegate: selectedContactDelegate?
    @IBOutlet weak var nameLabel: UILabel?
    
    @IBOutlet weak var tableView: UITableView!
    var contact : Person?
    var name: String?

    func tranferContact(with contact: Person) {
            name = contact.firstName
            print("Nhan")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DetailViewCell.nib, forCellReuseIdentifier: DetailViewCell.identifier)
        tableView.register(DetailImageViewCell.nib, forCellReuseIdentifier: DetailImageViewCell.identifier)
        tableView.register(NoteCell.nib, forCellReuseIdentifier: NoteCell.identifier)
        tableView.register(OneLineCell.nib, forCellReuseIdentifier: OneLineCell.identifier)
        nameLabel?.text = contact?.firstName
    }
}

extension ContactViewController: UITableViewDelegate {
    
}

extension ContactViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = itemsContact[indexPath.section]
        switch item {
        
        case .phone:
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailViewCell.identifier, for: indexPath) as! DetailViewCell
            return cell
        case .email:
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailViewCell.identifier, for: indexPath) as! DetailViewCell
            return cell
        case .address:
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailImageViewCell.identifier, for: indexPath) as! DetailImageViewCell
            return cell
        case .birthday:
             let cell = tableView.dequeueReusableCell(withIdentifier: DetailViewCell.identifier, for: indexPath) as! DetailViewCell
            return cell
        case .note:
            let cell = tableView.dequeueReusableCell(withIdentifier: NoteCell.identifier, for: indexPath) as! NoteCell
            return cell
        case .sendMessage:
            let cell = tableView.dequeueReusableCell(withIdentifier: OneLineCell.identifier, for: indexPath) as! OneLineCell
            cell.titleLabel.text = "Send Message"
            return cell
        case .shareContact:
            let cell = tableView.dequeueReusableCell(withIdentifier: OneLineCell.identifier, for: indexPath) as! OneLineCell
            cell.titleLabel.text = "Share Contact"
            return cell
        }
    }
    
    
}




    
    
    




