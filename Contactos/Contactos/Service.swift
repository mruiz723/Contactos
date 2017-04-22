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
    "Content-Type": "application/json"
]

class Service: NSObject {
    
    typealias CompletionHandler = (_ sucess:Bool, _ response:[[String: AnyObject]]) ->()
    
    private let urlBase = "https://baas.kinvey.com"
    private let contacts = "/appdata/kid_W1DbAwgKW-/Contacts"
    
    func contacts(_ completion: @escaping CompletionHandler) {
        let url = urlBase + contacts
        Alamofire.request(url, headers: headers).responseJSON(){ response in
            
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
    
    
    
    
}
