//
//  ViewController.swift
//  Contactos
//
//  Created by Marlon David Ruiz Arroyave on 21/04/17.
//  Copyright © 2017 nextU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var updateButton: UIButton!
    
    //MARK: Properties
    var identifierView: String!
    var contact = Contact()
    var model: Contact!
    
    //MARK: IBActions
    @IBAction func saveContact(_ sender: Any) {
        
    }
    
    @IBAction func updateContact(_ sender: Any) {
        
    }
    
    //MARK: lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        nameTextField.text = contact.name
        lastNameTextField.text = contact.lastName
        phoneTextField.text = contact.phone
        emailTextField.text = contact.email
        
        if identifierView == "detail" {
            saveButton.isHidden = true
        }else if identifierView == "add" {
            updateButton.isHidden = true
            saveButton.isHidden = false
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

