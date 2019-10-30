//
//  ViewController.swift
//  ContactApp
//
//  Created by Trung Hieu on 10/28/19.
//  Copyright © 2019 Trung Hieu. All rights reserved.
//

import UIKit
let data: [Person] = [ Person(firstName: "Hieu", lastName: "Bui", phoneNumber: "0981228431", email: "hieu.bui@savvycomsoftware.com", profilePicture: UIImage(named: "")),
Person(firstName: "Aieu", lastName: "Bui", phoneNumber: "0981228431", email: "hieu.bui@savvycomsoftware.com", profilePicture: UIImage(named: "")),
Person(firstName: "Buy", lastName: "Nguyen", phoneNumber: "0981228431", email: "hieu.bui@savvycomsoftware.com", profilePicture: UIImage(named: "")),
Person(firstName: "Coang", lastName: "Le", phoneNumber: "0981228431", email: "hieu.bui@savvycomsoftware.com", profilePicture: UIImage(named: "")),
Person(firstName: "Diep", lastName: "Tran", phoneNumber: "0981228431", email: "hieu.bui@savvycomsoftware.com", profilePicture: UIImage(named: "")),
Person(firstName: "Eai", lastName: "Nguyen", phoneNumber: "0981228431", email: "hieu.bui@savvycomsoftware.com", profilePicture: UIImage(named: "")),
Person(firstName: "Fuong", lastName: "Bui", phoneNumber: "0981228431", email: "hieu.bui@savvycomsoftware.com", profilePicture: UIImage(named: ""))]


protocol selectedContactDelegate: class {
    func tranferContact(with contact: Person)
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var contactDictionary = [String:[String]]()
    var contactSectionTitle = [String]()
    
    
    @IBOutlet weak var contactTableView: UITableView!
    var delegate: selectedContactDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for contact in data {
            let contactKey = String((contact.firstName?.prefix(1) ?? ""))
            if var contactValues = contactDictionary[contactKey] {
                contactValues.append(contact.firstName ?? "")
                contactDictionary[contactKey] = contactValues
            } else {
                contactDictionary[contactKey] = [(contact.firstName ?? "")]
            }
        }
        contactSectionTitle = [String](contactDictionary.keys)
        contactSectionTitle = contactSectionTitle.sorted(by: {$0 < $1})
        
        contactTableView.delegate = self
        contactTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    var contact: Person?
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return contactSectionTitle.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contactCell = contactTableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        
        let contactKey = contactSectionTitle[indexPath.section]
        if let contactValues = contactDictionary[contactKey]{
//            let fullName = (data[indexPath.row].lastName ?? "") + " " + (data[indexPath.row].firstName ?? "")
            contactCell.textLabel?.text = contactValues[indexPath.row]
        }
        
        return contactCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        contact = data[indexPath.row]
        delegate?.tranferContact(with: contact! )
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return contactSectionTitle[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return contactSectionTitle
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MainToDetail" {
            let contactViewController = segue.destination as! ContactViewController
            contactViewController.contact = contact
            print("Gui")
        }
    }
    
}

