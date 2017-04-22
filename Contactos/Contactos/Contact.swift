//
//  Contact.swift
//  Contactos
//
//  Created by Marlon David Ruiz Arroyave on 21/04/17.
//  Copyright © 2017 nextU. All rights reserved.
//

import Foundation

class Contact {
    
    typealias CompletionHandler = (_ sucess:Bool, _ response:[Contact]) ->()
    
    
    //MARK: - Properties
    var id: String?
    var name: String?
    var lastName: String?
    var phone: String?
    var email: String?
    var service = Service()
    var contactsAgenda = [Contact]()
    
    //MARK: - Init
    init(id: String, name: String, lastName: String, phone: String, email: String) {
        self.id = id
        self.name = name
        self.lastName = lastName
        self.phone = phone
        self.email = email
        
    }
    
    convenience init(){
        
        self.init(id:"", name:"", lastName:"", phone:"", email:"")
        
    }
    
    func contacts(_ completion:@escaping CompletionHandler) {
        
        service.contacts { (success, data) in
            if success {
                self.contactsAgenda.removeAll()
                
                for item in data {
                   let contact = Contact(id: item["_id"] as! String, name: item["name"] as! String, lastName: item["last_name"] as! String, phone:item["phone"] as? String ?? "", email: item["email"] as! String)
                    self.contactsAgenda.append(contact)
                    
                }
                completion(true, self.contactsAgenda)
            }
        }
    }
    
    func saveContact(_ contact: Contact, completion:@escaping CompletionHandler) {
        
        let parameters : [String: AnyObject] = ["name": contact.name! as AnyObject, "last_name": contact.lastName! as AnyObject, "phone":contact.phone! as AnyObject, "email":contact.email! as AnyObject]
        
        
        service.saveContact(parameters) { (success, data) in
            if success {
                self.contactsAgenda.append(contact)
                
            }
            completion(success, self.contactsAgenda)
        }
        
    }
    
    func toDictionary() -> [String: AnyObject] {
        
        let dict: [String: AnyObject] = [
            "name": self.name! as AnyObject,
            "last_name": self.lastName! as AnyObject,
            "phone": self.phone! as AnyObject,
            "email": self.email! as AnyObject
        ]
        
        return dict
        
//        let parameters : [String: AnyObject] = ["name": contact.name! as AnyObject, "last_name": contact.lastName! as AnyObject, "phone":contact.phone! as AnyObject, "email":contact.email! as AnyObject]
    }
    
    
}

