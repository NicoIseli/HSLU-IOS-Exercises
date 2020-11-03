//
//  ViewController.swift
//  EditList
//
//  Created by nico on 06.10.20.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var firstNameLabel: UILabel!
    
    @IBOutlet weak var lastNameLabel: UILabel!
    
    @IBOutlet weak var postalCodeLabel: UILabel!
    
    var person: Person?
    
    override func viewDidLoad() {
            super.viewDidLoad()
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.firstNameLabel.text = self.person!.firstName
        self.lastNameLabel.text = self.person!.lastName
        self.postalCodeLabel.text = String(self.person!.plz)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "edit", let editViewController = segue.destination as? EditViewController{
            //editViewController.modalPresentationStyle = .fullScreen
            editViewController.person = self.person
        }
    }
}

