//
//  ViewController.swift
//  ModalDemo
//
//  Created by nico on 29.09.20.
//

import UIKit

class ViewController: UIViewController {
    
    /*
     * PROPERTIES OF THE CLASS
     */
    @IBOutlet weak var counterLabel: UILabel!
    
    var appearanceCounter : Int = -1
    
    
    
    /*
     * FUNCTION PROVIDED BY VIEWCONTROLLER
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    
    /*
     * IBACTION FUNCTIONS
     */
    @IBAction func showSecondView(sender: UIButton){
        let secondViewController = SecondViewController()
        
        //present(secondViewController, animated: true)
        show(secondViewController, sender: sender)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.appearanceCounter = self.appearanceCounter + 1
        self.counterLabel.text = String(self.appearanceCounter)
    }
 
}

