//
//  ContactViewController.swift
//  ContactApp
//
//  Created by Trung Hieu on 10/29/19.
//  Copyright © 2019 Trung Hieu. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController , selectedContactDelegate{
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var phoneNumberLable: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ViewController {
            destination.delegate = self
            print("Nhan dcc")
        }
    }
    func tranferContact(with contact: Person) {
            fullNameLabel.text = contact.lastName
            phoneNumberLable.text = contact.phoneNumber
            emailLabel.text = contact.email
    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



