//
//  SecondViewController.swift
//  ModalDemo
//
//  Created by nico on 29.09.20.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonPressed(sender: UIButton){
        let viewController = ViewController()
        dismiss(animated: true, completion: nil)
    }

}
