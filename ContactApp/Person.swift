//
//  Person.swift
//  ContactApp
//
//  Created by Trung Hieu on 10/29/19.
//  Copyright © 2019 Trung Hieu. All rights reserved.
//

import Foundation
import UIKit
import Contacts
class Person: Codable {
    var firstName: String
    var lastName: String
    var phoneNumber: String?
    var email: String?
//    let profilePicture: UIImage?
//    var phoneNumberField: (CNLabeledValue<CNPhoneNumber>)?
    
    init(firstName: String, lastName: String, phoneNumber: String?, email: String?) {
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.email = email
        
    }
    
}

extension Person {
  var contactValue: CNContact {
    let contact = CNMutableContact()
    contact.givenName = firstName
    contact.familyName = lastName
    contact.emailAddresses = [CNLabeledValue(label: CNLabelWork, value: email! as NSString)]
//    if let profilePicture = profilePicture {
//      let imageData = profilePicture.jpegData(compressionQuality: 1)
//      contact.imageData = imageData
//    }
//    if let phoneNumberField = phoneNumberField {
//      contact.phoneNumbers.append(phoneNumberField)
//    }
    return contact.copy() as! CNContact
  }
  
//  convenience init?(contact: CNContact) {
//    guard let email = contact.emailAddresses.first else { return nil }
//    let firstName = contact.givenName
//    let lastName = contact.familyName
//    let workEmail = email.value as String
//    var profilePicture: UIImage?
//    if let imageData = contact.imageData {
//      profilePicture = UIImage(data: imageData)
//    }
//    self.init(firstName: firstName, lastName: lastName, email: workEmail, profilePicture: profilePicture)
//    if let contactPhone = contact.phoneNumbers.first {
//      phoneNumberField = contactPhone
//    }
//  }
}

enum sectionType {
    case name
    case phone
    case addphone
    case email
    case ringtone
    case texttone
    case url
    case address
    case birthday
    case date
    case relatename
    case socialprofile
    case instantmessage
}

enum inSectionType {
    case add
    case click
}

struct Item {
    var type: sectionType
    var numberOfRow = 1
    var inSections = [InSectionCell](arrayLiteral:InSectionCell(type: .click))
    init(type: sectionType) {
        self.type = type
    }
}

struct InSectionCell {
    var type: inSectionType?
    init(type: inSectionType) {
        self.type = type
    }
}
