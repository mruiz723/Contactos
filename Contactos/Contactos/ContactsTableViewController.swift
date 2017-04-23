//
//  ContactsTableViewController.swift
//  Contactos
//
//  Created by Marlon David Ruiz Arroyave on 21/04/17.
//  Copyright © 2017 nextU. All rights reserved.
//

import UIKit
import SVProgressHUD

class ContactsTableViewController: UITableViewController, ViewControllerDelegate {
    
    //MARK: - Properties
    var contact = Contact()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //Add footer of the table a view for showing separaton cell that are using.
        tableView.tableFooterView = UIView()
        
        SVProgressHUD.show()
        contact.contacts { (success, data) in
            
            
            if success {
                self.contact.contactsAgenda = data
                self.tableView.reloadData()
                
            }else {
                
            
            }
            SVProgressHUD.dismiss()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contact.contactsAgenda.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell

        // Configure the cell...
        let contact = self.contact.contactsAgenda[indexPath.row]
        cell.nameLabel.text = contact.name!
        cell.lastNameLabel.text = contact.lastName!
        
        if let phone = contact.phone {
            cell.phoneLabel.text = phone
        }
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = self.contact.contactsAgenda[indexPath.row]
        performSegue(withIdentifier: "detail", sender: contact)
    }


    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Borrar") { (deleteAction, indexPath) in
            SVProgressHUD.show()
            let contactToDelete = self.contact.contactsAgenda[indexPath.row]
            self.contact.deleteContact(indexPath.row, contactID: contactToDelete.id!, completion: { (success) in
                SVProgressHUD.dismiss()
                let okAction = UIAlertAction(title:"OK", style:.default, handler:nil)
                if success {
                    self.tableView.reloadData()
                    self.makeAlert(title: "Contacto", message: "Su contacto ha sido eliminado satisfactoriamente", actions: [okAction])
                }else {
                        self.makeAlert(title: "Contacto", message: "Algo extraño ocurrio, por favor intente de nuevo.", actions: [okAction])
                }
            })
        }
        return [deleteAction]
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let detailVC = segue.destination as! ViewController
        detailVC.delegate = self
        if segue.identifier == "add" {
            detailVC.identifierView = segue.identifier
            detailVC.model = contact
        }else {
            detailVC.identifierView = "detail"
            detailVC.model = contact
            detailVC.contact = sender as! Contact
        }
    }
    
    // MARK: - ViewControllerDelegate
    func updateContacts() {
        self.tableView.reloadData()
    }
    

}
