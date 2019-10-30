//
//  ViewController.swift
//  ContactApp
//
//  Created by Trung Hieu on 10/28/19.
//  Copyright © 2019 Trung Hieu. All rights reserved.
//

import UIKit
let data: [Person] = [ Person(firstName: "An", lastName: "Bui", phoneNumber: "0981228431", email: "hieu.bui@savvycomsoftware.com", profilePicture: UIImage(named: "")),
Person(firstName: "Hieu", lastName: "Bui", phoneNumber: "0981228431", email: "hieu.bui@savvycomsoftware.com", profilePicture: UIImage(named: "")),
Person(firstName: "Anh", lastName: "Bui", phoneNumber: "0981228431", email: "hieu.bui@savvycomsoftware.com", profilePicture: UIImage(named: "")),
Person(firstName: "Cuong", lastName: "Nguyen", phoneNumber: "0981228431", email: "hieu.bui@savvycomsoftware.com", profilePicture: UIImage(named: "")),
Person(firstName: "Binh", lastName: "Le", phoneNumber: "0981228431", email: "hieu.bui@savvycomsoftware.com", profilePicture: UIImage(named: "")),
Person(firstName: "Duy", lastName: "Tran", phoneNumber: "0981228431", email: "hieu.bui@savvycomsoftware.com", profilePicture: UIImage(named: "")),
Person(firstName: "Hai", lastName: "Nguyen", phoneNumber: "0981228431", email: "hieu.bui@savvycomsoftware.com", profilePicture: UIImage(named: "")),
Person(firstName: "Phong", lastName: "Bui", phoneNumber: "0981228431", email: "hieu.bui@savvycomsoftware.com", profilePicture: UIImage(named: ""))]



protocol selectedContactDelegate: class {
    func tranferContact(with contact: Person)
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    
    @IBOutlet weak var contactTableView: UITableView!
    @IBOutlet weak var searchBar: UITableView!
    
    var contactDictionary = [String:[String]]()
    var contactSectionTitle = [String]()
    var contact: Person?
    var delegate: selectedContactDelegate?
    var currentContact = data
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for contact in currentContact {
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
        searchBar.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    //Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       let contactKey = contactSectionTitle[section]
        if let contactValues = contactDictionary[contactKey]{
            return contactValues.count
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return contactSectionTitle.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contactCell = contactTableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        
        let contactKey = contactSectionTitle[indexPath.section]
        if let contactValues = contactDictionary[contactKey]{
//            let fullName = (data[indexPath.row].lastName ?? "") + " " + contactValues[indexPath.row]
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
    
    // Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        currentContact = data.filter({ person -> Bool in
            guard let text = searchBar.text else {return false}
            return (person.firstName?.contains(text))!
        })
        print(currentContact.count)
        contactTableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
    }
    
    //Delagate
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MainToDetail" {
            let contactViewController = segue.destination as! ContactViewController
            contactViewController.contact = contact
            print("Gui")
        }
    }
    
}

