//
//  ViewController.swift
//  contactApp
//
//  Created by ddukk15 on 15/11/22.
//

import UIKit
import Contacts
import ContactsUI


struct Person {
    let name: String
    let id: String
    let source: CNContact
}
class ViewController: UIViewController,CNContactPickerDelegate,UITableViewDelegate,UITableViewDataSource {
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row].name
        return cell
        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let contact = models[indexPath.row].source
        let vc = CNContactViewController(for: contact)
        present(vc, animated: true)
    }
    
 var models = [Person]()
   
    
    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        table.dataSource = self
        table.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(didTapAdd))
    }
   @objc func didTapAdd(){
     let vc = CNContactPickerViewController()
        vc.delegate = self
        present(vc, animated: true)
        }
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        let name = contact.givenName + " " + contact.familyName
        let identifire = contact.identifier
        let modal = Person(
            name: name,
            id: identifire,
            source: contact)
        models.append(modal)
        table.reloadData()
    }
}



