//
//  DBWorker.swift
//  StarTask_test
//
//  Created by Gravman on 11.01.2020.
//  Copyright © 2020 Alexandr_P. All rights reserved.
//

import RealmSwift

protocol DBWorker {
    func save(_ contact: ContactRealm)
    func delete(_ contact: ContactRealm)
    func update(_ contact: ContactRealm)
    func fetch() -> [ContactRealm]?
}

class ContactWorker: DBWorker{
    
    let realm = try! Realm()
    
    func save(_ contact: ContactRealm){
        do{
            try realm.write {
                realm.add(contact)
            }
        } catch let saveErr {
            print("Can't save cause of: ", saveErr)
        }
    }
    
    
    func delete(_ contact: ContactRealm){
        
        let contacts = realm.objects(ContactRealm.self).filter("phoneNumber = %@", contact.phoneNumber)
        guard let contactToDelete = contacts.first else {return}
        do{
            try realm.write {
                realm.delete(contactToDelete)
            }
        } catch let delErr {
            print("Can't delete cause of: ", delErr)
        }
    }
    
    func update(_ contact: ContactRealm) {
        let contacts = realm.objects(ContactRealm.self).filter("phoneNumber = %@", contact.phoneNumber)
        do{
            try realm.write {
                contacts.first?.firstName = contact.firstName
                contacts.first?.phoneNumber = contact.phoneNumber
                contacts.first?.lastName = contact.lastName
            }
        } catch let updErr {
            print("Can't update cause of: ", updErr)
        }
    }
    
    
    func fetch() -> [ContactRealm]?{
        return Array(realm.objects(ContactRealm.self))
    }
}
