//
//  ViewController.swift
//  ContactApp
//
//  Created by Trung Hieu on 10/28/19.
//  Copyright © 2019 Trung Hieu. All rights reserved.
//

import UIKit
let data: [Person] = [ Person(firstName: "Hieu", lastName: "Bui", phoneNumber: "0981228431", email: "hieu.bui@savvycomsoftware.com", profilePicture: UIImage(named: "")),
Person(firstName: "Hieu", lastName: "Bui", phoneNumber: "0981228431", email: "hieu.bui@savvycomsoftware.com", profilePicture: UIImage(named: "")),
Person(firstName: "Huy", lastName: "Nguyen", phoneNumber: "0981228431", email: "hieu.bui@savvycomsoftware.com", profilePicture: UIImage(named: "")),
Person(firstName: "Hoang", lastName: "Le", phoneNumber: "0981228431", email: "hieu.bui@savvycomsoftware.com", profilePicture: UIImage(named: "")),
Person(firstName: "Hiep", lastName: "Tran", phoneNumber: "0981228431", email: "hieu.bui@savvycomsoftware.com", profilePicture: UIImage(named: "")),
Person(firstName: "Hai", lastName: "Nguyen", phoneNumber: "0981228431", email: "hieu.bui@savvycomsoftware.com", profilePicture: UIImage(named: "")),
Person(firstName: "Huong", lastName: "Bui", phoneNumber: "0981228431", email: "hieu.bui@savvycomsoftware.com", profilePicture: UIImage(named: ""))]


protocol selectedContactDelegate {
    func tranferContact(with contact: Person)
}
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var contactTableView: UITableView!
    var delegate: selectedContactDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        contactTableView.delegate = self
        contactTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contactCell = contactTableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        let fullName = (data[indexPath.row].lastName ?? "") + " " + (data[indexPath.row].firstName ?? "" )
        contactCell.textLabel?.text = fullName
        return contactCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(delegate != nil){
            delegate?.tranferContact(with: data[indexPath.row])
            print("Gui")
        }
    }
    
}

