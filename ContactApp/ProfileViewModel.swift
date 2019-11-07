//
//  ProfileViewModel.swift
//  ContactApp
//
//  Created by Trung Hieu on 11/6/19.
//  Copyright © 2019 Trung Hieu. All rights reserved.
//

import Foundation
import UIKit

enum ProfileViewModelItemType {
    case name
    case phone
    case email
    case url
    case address
    case birthday
}

protocol ProfileViewModelItem {
    var type: ProfileViewModelItemType { get }
    var sectionTitle: String { get }
    var rowCount: Int { get }
}

class ProfileViewModelNameItem: ProfileViewModelItem {
    var type: ProfileViewModelItemType {
        return .name
    }
    
    var sectionTitle: String {
        return " "
    }
    
    var rowCount: Int {
        return 3
    }
    
    var firstName: String
    var lastName: String
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}

class ProfileViewModelPhoneItem: ProfileViewModelItem {
    
    var sectionTitle: String {
        return " "
    }
    
    var rowCount: Int {
        return 1
    }
    
    var type: ProfileViewModelItemType {
        return .phone
    }
    
    var phones = [PhoneNumber]()
    init(phones: [PhoneNumber]) {
        self.phones = phones
    }
}

class ProfileViewModelEmailItem: ProfileViewModelItem {
    var type: ProfileViewModelItemType {
        return .email
    }
    
    var sectionTitle: String {
        return " "
    }
    
    var rowCount: Int {
        return 1
    }
    
    var emails = [Email]()
    init(emails : [Email]) {
        self.emails = emails
    }
}

