//
//  Person.swift
//  ContactApp
//
//  Created by Trung Hieu on 10/29/19.
//  Copyright © 2019 Trung Hieu. All rights reserved.
//

import Foundation
import UIKit
struct Person {
    let firstName: String?
    let lastName: String?
    let phoneNumber: String?
    let email: String?
    let profilePicture: UIImage?
    
    init(firstName: String?, lastName: String?, phoneNumber: String?, email: String?, profilePicture: UIImage?) {
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.email = email
        self.profilePicture = profilePicture
    }
    
}
