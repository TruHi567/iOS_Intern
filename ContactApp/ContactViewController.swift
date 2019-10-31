//
//  ContactViewController.swift
//  ContactApp
//
//  Created by Trung Hieu on 10/29/19.
//  Copyright © 2019 Trung Hieu. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController, selectedContactDelegate{
    
 
    var delegate: selectedContactDelegate?
    @IBOutlet weak var nameLabel: UILabel?
    
    var contact : Person?
    var name: String?
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if let nav = segue.destination as? UINavigationController, let svc = nav.topViewController as? ViewController{
                   svc.delegate = self
               }
        print("pre")
    }
    func tranferContact(with contact: Person) {
            name = contact.firstName
            print("Nhan")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel?.text = name
    }
}


    
    
    




