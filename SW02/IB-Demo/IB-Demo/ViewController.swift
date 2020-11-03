//
//  ViewController.swift
//  IB-Demo
//
//  Created by nico on 22.09.20.
//
//  SMALL APP TO CALCULATE BMI BASED ON SLIDER INPUT
//  FORMULA FOR BMI: (w/h^2) | w = weight in kg | h = height in meters
//
//  UNDERWEIGHT : < 18.5
//  NORMAL      : <= 18.5 < 25
//  OVERWEIGHT  : > 25
//

import UIKit

class ViewController: UIViewController {
    
    /*
     * VARIABLE TO HOLD VALUES FOR CALCULATIONS
     */
    
    var CURRENT_BMI : Float = 0
    var currentHeightInMeters : Float = 0
    var currentWeightInKilograms : Float = 0
    var currentBackgroundColorWhite : Bool = true
    
    /*
     * CREATE REFERENCE TO UI-COMPONENTS
     */

    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var weightSlider: UISlider!
    
    @IBOutlet weak var heightLabel: UILabel!
    
    @IBOutlet weak var heightSlider: UISlider!
    
    @IBOutlet weak var calculateButton: UIButton!
    
    @IBOutlet weak var loadSymbol: UIActivityIndicatorView!
    
    @IBOutlet weak var styleSwitcher: UISegmentedControl!
    
    @IBOutlet weak var loadingButton: UIButton!
    
    
    /*
     * FUNCTION TO HANDLE CHANGES OF WEIGHT SLIDER
     */
    
    @IBAction func onWeightSliderChanged(sender: UISlider){
        self.weightLabel.text = String(Int(sender.value)) + " kg"
        if sender.value > 100 && self.currentWeightInKilograms <= 100 {
            hunderetKGAlert()
        }
        self.currentWeightInKilograms = sender.value
    }
    
    
    
    /*
     * FUNCTION TO HANDLE CHANGES OF HEIGHT SLIDER
     */
    
    @IBAction func onHeightSliderChanged(sender: UISlider){
        self.heightLabel.text = String(Int(sender.value)) + " cm"
        self.currentHeightInMeters = sender.value / 100
    }
    
    
    
    /*
     * FUNCTION TO HANDLE THE CLICK ON CALCULATE BUTTON
     */
    
    @IBAction func onCalculateButtonPressed(sender: UIButton){
        
        // Eliminate chance to divide by zero
        if self.currentHeightInMeters != 0 {
            
            // Calculate current bmi
            self.CURRENT_BMI = self.currentWeightInKilograms / (pow(self.currentHeightInMeters, 2))
            
            // Evaluate BMI
            if self.CURRENT_BMI < 18.5 {
                createBMIPopUpWindow(bmi: self.CURRENT_BMI, message: "you are underweight - go and get some food! 🍔🍔🍔")
            } else if self.CURRENT_BMI >= 18.5 && self.CURRENT_BMI < 25 {
                createBMIPopUpWindow(bmi: self.CURRENT_BMI, message: "you are normal - well done! 🤓🤓🤓")
            } else {
                createBMIPopUpWindow(bmi: self.CURRENT_BMI, message: "you are overweight - gang go trainiere du fetti sau 🏋🏻‍♂️🏋🏻‍♂️🏋🏻‍♂️")
            }
            
        } else {
            createErrorWindow()
        }
    }
    
    
    
    /*
     * FUNCTION TO HANDLE THE CHANGE ON THE STYLE SWITCHER
     */
    
    @IBAction func onStyleSwitcherChanged(sender: UISegmentedControl){
        if currentBackgroundColorWhite {
            self.view.backgroundColor = UIColor(red: 0.91, green: 0.96, blue: 1.00, alpha: 1.00)
            self.currentBackgroundColorWhite = false
        } else {
            self.view.backgroundColor = UIColor.white
            self.currentBackgroundColorWhite = true
        }
    }
    
    
    
    /*
     * FUNCTION TO HANDLE LOADING ICON
     */
    
    @IBAction func onLoadButtonPressed(sender: UIButton){
        if self.loadSymbol.isAnimating {
            self.loadSymbol.stopAnimating()
            self.loadingButton.setTitle("Start", for: .normal)
        } else {
            self.loadSymbol.startAnimating()
            self.loadingButton.setTitle("Stop", for: .normal)
        }
    }
    
    
    
    /*
     * FUNCTION TO CREATE A POP UP WINDOW
     */
    
    func createBMIPopUpWindow(bmi : Float, message : String) {
        let alertController = UIAlertController(
            title: "Your BMI result",
            message: String(Int(bmi)) + "! " + message ,
            preferredStyle: .alert)
        let defaultAction = UIAlertAction(
            title: "OK",
            style: .cancel,
            handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    /*
     * FUNCTION TO HANDLE DIVISION BY ZERO
     */
    
    func createErrorWindow() {
        let alertController = UIAlertController(
            title: "ERROR",
            message: "Your height should be taller than zero!",
            preferredStyle: .alert)
        let defaultAction = UIAlertAction(
            title: "OK",
            style: .cancel,
            handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    /*
     * FUNCTION TO HANDLE DIVISION BY ZERO
     */
    
    func hunderetKGAlert() {
        let alertController = UIAlertController(
            title: "100 kg",
            message: "Really??? 😳😳😳",
            preferredStyle: .alert)
        let defaultAction = UIAlertAction(
            title: "OK",
            style: .cancel,
            handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    /*
     * PROVIDED FUNCTION BY VIEW CONTROLLER
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

