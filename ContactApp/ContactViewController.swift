//
//  ContactViewController.swift
//  ContactApp
//
//  Created by Trung Hieu on 10/29/19.
//  Copyright © 2019 Trung Hieu. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController{
 
    @IBOutlet weak var nameLabel: UILabel?
    var contact : Person?
    var name: String?
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let destination = segue.destination as? ViewController {
//            destination.delegate = self
//        }
//    }
//    func tranferContact(with contact: Person) {
//        name = contact.firstName ?? "NoOne"
//    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        nameLabel?.text = contact?.firstName
       

        // Do any additional setup after loading the view.
    }
    
    


}



