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


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    
    @IBOutlet weak var contactTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var contactDictionary = [String:[Person]]()
    var contactSectionTitle = [String]()
    var contact: Person?
    var data = [Person](){
        didSet {
            DispatchQueue.main.async {
                self.contactTableView.reloadData()
            }
        }
    }
    var selectedItemIndexPath: IndexPath?

    
    var isSearchBarEmpty: Bool {
      return searchBar.text?.isEmpty ?? true
    }
    
    var dataContact = [Person](){
        didSet {
            DispatchQueue.main.async {
                self.contactTableView.reloadData()
            }
        }
    }
    var currentContact : [Person]? = []
    
    
    //MARK: Load Data
    func loadDataSource(){
        let contactDecoder = JSONDecoder()
        do {
            guard let url = Bundle.main.url(forResource: "data", withExtension: "json")  else {
                return
            }
            guard let contactJSONData = try? Data(contentsOf: url) else {
                return
            }
            
            let dataContact = try contactDecoder.decode([Person].self, from: contactJSONData)
            self.data = dataContact
            
            
        } catch {
            print("Failed to decode contacts: \(error.localizedDescription)")
        }
        contactTableView.reloadData()
    }
    
    func loadData(){
        dataContact = data
        //data.removeAll()
        
        for contact in dataContact {
            let contactKey = String((contact.firstName.prefix(1).uppercased()))
            if var contactValues = contactDictionary[contactKey] {
                contactValues.append(contact)
                contactDictionary[contactKey] = contactValues
            } else {
                contactDictionary[contactKey] = [(contact)]
            }
        }
        contactSectionTitle = [String](contactDictionary.keys)
        contactSectionTitle = contactSectionTitle.sorted(by: {$0 < $1})
        contactTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataContact.removeAll()
        contactTableView.reloadData()
       
        
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataSource()
        loadData()
        contactTableView.delegate = self
        contactTableView.dataSource = self
        searchBar.delegate = self
    }
    
    //MARK: Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if !isSearchBarEmpty {
            return currentContact!.count
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
            fullName = currentContact![indexPath.row].lastName + " " + currentContact![indexPath.row].firstName
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
        selectedItemIndexPath = indexPath
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        contactTableView.cellForRow(at: indexPath)?.isSelected = false
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
    

    
    //MARK: Search Bar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        currentContact = data.filter({ person -> Bool in
            guard let text = searchBar.text?.lowercased() else {return false}
            return (person.firstName.lowercased().contains(text) || person.lastName.lowercased().contains(text))
        })
        contactTableView.reloadData()
    }
    
    //segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? UINavigationController,
            let avc = destination.topViewController as? AddContactViewController{
            avc.delegate = self
        }
        
        if segue.identifier == "MainToDetail"{
            if let cvc = segue.destination as? ContactViewController{
                var contactSelected: Person
                if let index = selectedItemIndexPath {
                    if(!isSearchBarEmpty){
                        contactSelected = currentContact![index.row]
                        cvc.contact = contactSelected
                    } else {
                        let contactKey = contactSectionTitle[index.section]
                        if let contactValues = contactDictionary[contactKey]{
                            contactSelected = contactValues[index.row]
                            cvc.contact = contactSelected
                        }
                    }
                }
            }
        }
    }
    
}

//MARK: Delegate
extension ViewController: AddContactDelegate {
    func addContact(person: Person) {
        data.append(person)
        loadData()
    }
}

extension ViewController: SendBackEditedContactDelegate {
    func sendBackEditedContact(contact: Person) {
    }
}



