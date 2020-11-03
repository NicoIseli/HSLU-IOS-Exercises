//
//  ViewController.swift
//  EditList
//
//  Created by nico on 06.10.20.
//

import UIKit

class EditViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var firstNameLabel: UITextField!
    
    @IBOutlet weak var lastNameLabel: UITextField!
    
    @IBOutlet weak var postalCodeLabel: UITextField!
    
    var person: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameLabel.delegate = self
        lastNameLabel.delegate = self
        postalCodeLabel.delegate = self

        loadData()
    }
    
    
    func loadData() {
            if let p = self.person {
                if let textField = self.firstNameLabel {
                    textField.text = p.firstName
                }
                if let textField = self.lastNameLabel {
                    textField.text = p.lastName
                }
                if let textField = self.postalCodeLabel {
                    textField.text = String(p.plz)
                }
            }
        }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        person?.firstName = firstNameLabel.text ?? ""
        person?.lastName = lastNameLabel.text ?? ""
        person?.plz = Int(postalCodeLabel.text ?? "0") ?? 0
        self.dismiss(animated: true, completion: nil)
        
    }
    
    /*
    @objc func dismissKeyboard() {
          view.endEditing(true)
      }
    */
      
      func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          textField.resignFirstResponder()
          return true
      }
    
}
