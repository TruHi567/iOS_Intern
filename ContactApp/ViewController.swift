//
//  ViewController.swift
//  ContactApp
//
//  Created by Trung Hieu on 10/28/19.
//  Copyright © 2019 Trung Hieu. All rights reserved.
//

import UIKit
import ContactsUI
import Contacts

let data: [Person] = [ Person(firstName: "An", lastName: "Nguyen", email: "hieu.bui@savvycomsoftware.com", profilePicture: UIImage(named: "")),
Person(firstName: "Hieu", lastName: "Bui", email: "hieu.bui@savvycomsoftware.com", profilePicture: UIImage(named: "")),
Person(firstName: "Anh", lastName: "Hoang",  email: "hieu.bui@savvycomsoftware.com", profilePicture: UIImage(named: "")),
Person(firstName: "Cuong", lastName: "Nguyen", email: "hieu.bui@savvycomsoftware.com", profilePicture: UIImage(named: "")),
Person(firstName: "Binh", lastName: "Le",  email: "hieu.bui@savvycomsoftware.com", profilePicture: UIImage(named: "")),
Person(firstName: "Duy", lastName: "Tran",  email: "hieu.bui@savvycomsoftware.com", profilePicture: UIImage(named: "")),
Person(firstName: "Hai", lastName: "Nguyen",  email: "hieu.bui@savvycomsoftware.com", profilePicture: UIImage(named: "")),
Person(firstName: "Phong", lastName: "Bui",  email: "hieu.bui@savvycomsoftware.com", profilePicture: UIImage(named: ""))]



protocol selectedContactDelegate: class {
    func tranferContact(with contact: Person)
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    
    @IBOutlet weak var contactTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
   
     
    var contactDictionary = [String:[Person]]()
    var contactSectionTitle = [String]()
    var contact: Person?
    var delegate: selectedContactDelegate?
    var currentContact: [Person] = []
    
    var isSearchBarEmpty: Bool {
      return searchBar.text?.isEmpty ?? true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentContact = data
        for contact in data {
            let contactKey = String((contact.firstName.prefix(1) ))
            if var contactValues = contactDictionary[contactKey] {
                contactValues.append(contact)
                contactDictionary[contactKey] = contactValues
            } else {
                contactDictionary[contactKey] = [(contact)]
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
        if !isSearchBarEmpty {
            return currentContact.count
        } else {
            let contactKey = contactSectionTitle[section]
            if let contactValues = contactDictionary[contactKey]{
                return contactValues.count
            }
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if !isSearchBarEmpty {
            return 1
        }
        return contactSectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contactCell = contactTableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        var fullName = ""
        if !isSearchBarEmpty {
            fullName = currentContact[indexPath.row].lastName + " " + currentContact[indexPath.row].firstName
            contactCell.textLabel?.text = fullName
        } else {
            let contactKey = contactSectionTitle[indexPath.section]
            if let contactValues = contactDictionary[contactKey]{
                 fullName = (contactValues[indexPath.row].lastName ) + " " + (contactValues[indexPath.row].firstName )
                
                contactCell.textLabel?.text = fullName
            }
        }
        return contactCell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var contactSelected: Person
        let contactKey = contactSectionTitle[indexPath.section]
        if let contactValues = contactDictionary[contactKey]{
            
            contactSelected = contactValues[indexPath.row]
            contact = contactSelected
            print(contactSelected.firstName)
           
            if delegate != nil{
                delegate?.tranferContact(with: contactSelected)
                navigationController?.dismiss(animated: true)
                print("Gui")
            }
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if !isSearchBarEmpty {
            return nil
        }
        return contactSectionTitle[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if !isSearchBarEmpty {
            return nil
        }
        return contactSectionTitle
    }
    
    // Search Bar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        currentContact = data.filter({ person -> Bool in
            guard let text = searchBar.text?.lowercased() else {return false}
            return (person.firstName.lowercased().contains(text) || person.lastName.lowercased().contains(text))
        })
        print(currentContact.count)
        for index in currentContact{
            print(index.firstName)
        }
        contactTableView.reloadData()
    }
    
    //segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MainToDetail" {
            let contactViewController = segue.destination as! ContactViewController
            contactViewController.contact = contact
            contactViewController.delegate = self as? selectedContactDelegate
            print(contact?.firstName ?? "NoOne")
            print("Gui")
        }
    }
    
}

// MARK: - CustomTableViewCellDelegate
extension ViewController: AddButtonCellDelegate {

    func cell(cell: UITableViewCell?, touchButtonAt indexPath: IndexPath?) {
        print("touch buton at indexpath \(indexPath)")
    }
}



