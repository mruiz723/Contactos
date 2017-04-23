//
//  ViewController.swift
//  Contactos
//
//  Created by Marlon David Ruiz Arroyave on 21/04/17.
//  Copyright © 2017 nextU. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol ViewControllerDelegate:class {
    func updateContacts()
}

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
    weak var delegate: ViewControllerDelegate?
    var oKAction = UIAlertAction()
    
    //MARK: IBActions
    @IBAction func saveContact(_ sender: Any) {
        if (nameTextField.text?.isEmpty)! || (lastNameTextField.text?.isEmpty)! || (phoneTextField.text?.isEmpty)! || (emailTextField.text?.isEmpty)! {
            
            let alert = UIAlertController(title: "Contacto", message: "Todos los campos son requeridos.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            
        }else {
            let contact = Contact(id: "0", name: nameTextField.text!, lastName: lastNameTextField.text!, phone: phoneTextField.text!, email: emailTextField.text!)
            
            model.saveContact(contact, completion: { (success, data) in
                
                if success {
                    self.model.contactsAgenda = data
                    self.makeAlert(title:"Contacto", message: "Su contacto ha sido guardado!!!", actions: [self.oKAction])
                    self.delegate?.updateContacts()
                }else {
                    self.makeAlert(title:"Contacto", message: "Algo extraño ocurrio, por favor intente de nuevo.", actions: [self.oKAction])
                }
            })
        }
    }
    
    @IBAction func updateContact(_ sender: Any) {
        SVProgressHUD.show()
        if (nameTextField.text?.isEmpty)! || (lastNameTextField.text?.isEmpty)! || (phoneTextField.text?.isEmpty)! || (emailTextField.text?.isEmpty)! {
            
            let alert = UIAlertController(title: "Contacto", message: "Todos los campos son requeridos.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            
        }else {
            contact.name = nameTextField.text
            contact.lastName = lastNameTextField.text
            contact.phone = phoneTextField.text
            contact.email = emailTextField.text
            model.updateContact(contact) { (success) in
                SVProgressHUD.dismiss()
                if success {
                    self.makeAlert(title: "Contacto", message: "Su contacto ha sido actualizado!!!", actions: [self.oKAction])
                    self.delegate?.updateContacts()
                }else {
                    self.makeAlert(title: "Contacto", message: "Algo extraño ocurrio, por favor intente de nuevo.", actions: [self.oKAction])
                }
                
            }
        }
        
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
        
        oKAction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
            _ = self.navigationController?.popViewController(animated: true)
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension UIViewController {
    func makeAlert(title: String, message: String, actions:[UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for item in actions {
            alert.addAction(item)
        }
        self.present(alert, animated: true, completion: nil)
    }
}

