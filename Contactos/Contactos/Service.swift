//
//  Service.swift
//  Contactos
//
//  Created by Marlon David Ruiz Arroyave on 21/04/17.
//  Copyright © 2017 nextU. All rights reserved.
//

import UIKit
import Alamofire


let headers = [
    "Authorization": "Basic a2lkX1cxRGJBd2dLVy06MDE5Y2VhMzBiZGNlNDEwMjlkMjk4ZGQ0MWMzMWQ3ZGQ=",
    "Content-Type": "application/x-www-form-urlencoded"
]

typealias CompletionHandlerUpdateDelete = (_ sucess:Bool) ->()

class Service: NSObject {
    
    typealias CompletionHandlerGET = (_ sucess:Bool, _ response:[[String: AnyObject]]) ->()
    typealias CompletionHandler = (_ success:Bool, _ response:[String: AnyObject] ) -> ()
    
    
    private let urlContacts = "https://baas.kinvey.com/appdata/kid_W1DbAwgKW-/Contacts"
    
    func contacts(_ completion: @escaping CompletionHandlerGET) {
        Alamofire.request(urlContacts, headers: headers).responseJSON(){ response in
            
            switch response.result {
            case .success(let JSON):
                print(JSON)
            completion(true, JSON as! [[String : AnyObject]])
            case .failure(let error):
                print(error)
                completion(false, [["error" : error.localizedDescription as AnyObject]])
            }
            
        }
    }
    
    
    func saveContact(_ parameters:[String: AnyObject], completion:@escaping CompletionHandler) {
        Alamofire.request(urlContacts, method:.post, parameters:parameters, headers:headers)
            .responseJSON(){response in
            
            switch response.result {
            case .success(let JSON):
                print(JSON)
                completion(true, JSON as! [String : AnyObject])
            case .failure(let error):
                print(error)
                completion(false, ["error" : error.localizedDescription as AnyObject])
            }
        }
    }
    
    func updateContact (_ contactID:String,  parameters: [String: AnyObject], completion: @escaping CompletionHandlerUpdateDelete) {
        let url = urlContacts + contactID
        Alamofire.request(url, method:.put, parameters: parameters, headers:headers).responseJSON() { response in
            switch response.result {
            case .success(let JSON):
                print(JSON)
                completion(true)
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
    
    func deleteContact (_ contactID:String, completion: @escaping CompletionHandlerUpdateDelete) {
        let url = urlContacts + contactID
        Alamofire.request(url, method:.delete, headers:headers).responseJSON() { response in
            switch response.result {
            case .success(let JSON):
                print(JSON)
                completion(true)
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }

    
}
