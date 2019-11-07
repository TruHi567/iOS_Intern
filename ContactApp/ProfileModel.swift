//
//  ProfileModel.swift
//  ContactApp
//
//  Created by Trung Hieu on 11/6/19.
//  Copyright © 2019 Trung Hieu. All rights reserved.
//

import Foundation

public func dataFromFile(_ filename: String) -> Data? {
    @objc class TestClass: NSObject { }
    
    let bundle = Bundle(for: TestClass.self)
    if let path = bundle.path(forResource: filename, ofType: "json") {
        return (try? Data(contentsOf: URL(fileURLWithPath: path)))
    }
    return nil
}

class Profile{
    var firstName: String?
    var lastName: String?
    var phoneNumbers = [PhoneNumber]()
    var emails = [Email]()
    var url: String?
    var address: String?
    var birthday: Date?
    
    init?(data: Data) {
        do {
            if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any], let body = json["data"] as? [String: Any] {
                self.firstName = body["firstName"] as? String
                self.lastName = body["lastName"] as? String
                   
                if let phoneNumbers = body["phoneNumbers"] as? [[String: Any]] {
                    self.phoneNumbers = phoneNumbers.map { PhoneNumber(json: $0)}
                }
                   
                if let emails = body["emails"] as? [[String: Any]] {
                    self.emails = emails.map { Email(json: $0) }
                }
                
                self.url = body["url"] as? String
                self.address = body["address"] as? String
                self.birthday = body["birthday"] as? Date
               }
           } catch {
               print("Error deserializing JSON: \(error)")
               return nil
           }
       }
    
}

class PhoneNumber {
    var type: String?
    var number: String?
    
    init(json: [String: Any]) {
        self.type = json["type"] as? String
        self.number = json["number"] as? String
    }
}

class Email{
    var type: String?
    var mail: String?
    
    init(json: [String: Any]) {
        self.type = json["type"] as? String
        self.mail = json["mail"] as? String
    }
}

enum PhoneNumberType {
    case home
    case work
    case school
    case iPhone
    case mobile
    case main
    case homefax
    case workfax
    case pager
    case other
}

enum EmailType {
    case home
    case work
    case school
    case iCloud
    case other
}
