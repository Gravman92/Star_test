//
//  Contact.swift
//  StarTask_test
//
//  Created by Gravman on 11.01.2020.
//  Copyright © 2020 Alexandr_P. All rights reserved.
//


import RealmSwift

class ContactRealm: Object {
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var phoneNumber: String = ""
    @objc dynamic var phoneType: String = ""
}
