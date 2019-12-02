//
//  ContactViewController.swift
//  ContactApp
//
//  Created by Trung Hieu on 10/29/19.
//  Copyright © 2019 Trung Hieu. All rights reserved.
//

import UIKit

protocol SendBackEditedContactDelegate {
    func sendBackEditedContact(contact: Person);
}

class ContactViewController: UIViewController{
    
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
 
    
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var tableView: UITableView!
    
    var contact : Person?
    var name: String?
    var delegate: SendBackEditedContactDelegate?

    func tranferContact(with contact: Person) {
            name = contact.firstName
            print("Nhan")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameLabel?.text = (contact?.lastName ?? "") + " " + (contact?.firstName ?? "")
        tableView.reloadData()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.backItem?.backBarButtonItem?.title = "Contacts"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DetailViewCell.nib, forCellReuseIdentifier: DetailViewCell.identifier)
        tableView.register(DetailImageViewCell.nib, forCellReuseIdentifier: DetailImageViewCell.identifier)
        tableView.register(NoteCell.nib, forCellReuseIdentifier: NoteCell.identifier)
        tableView.register(OneLineCell.nib, forCellReuseIdentifier: OneLineCell.identifier)
        

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent{
            delegate?.sendBackEditedContact(contact: contact!)
            print("SendBack")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailToEdit"{
            let ecvc = segue.destination as? EditContactViewController
            ecvc?.contact = contact
        }
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
            cell.detailLabel.text = contact?.phoneNumber
            return cell
        case .email:
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailViewCell.identifier, for: indexPath) as! DetailViewCell
            cell.detailLabel.text = contact?.email
            return cell
        case .address:
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailImageViewCell.identifier, for: indexPath) as! DetailImageViewCell
            cell.detailLabel.text = "Address"
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = false
    }
}

extension ContactViewController: SendEditedContactDelegate{
    func sendEditedContact(contact: Person) {
        self.contact = contact
        tableView.reloadData()
    }
    
}




    
    
    




