//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextFiled: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    @IBOutlet weak var myStepper: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    var tip = 0.1
    var split = 2.0
    
    var totalBill = 0.0
    
    var resultTotal = 0.0
    
    @IBAction func tipChanged(_ sender: UIButton) {
        
        billTextFiled.endEditing(true)
        
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        sender.isSelected = true
        
        let buttonTitle = sender.currentTitle!
        
        let buttonTitleWithoutPercentage = String(buttonTitle.dropLast())
        
        let buttonTitleAsNumber = Double(buttonTitleWithoutPercentage)!
        
        tip = buttonTitleAsNumber / 100
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        billTextFiled.endEditing(true)
        splitNumberLabel.text = String(format: "%.0f", myStepper.value)
        split = myStepper.value
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        
        let bill = billTextFiled.text!
        
        if bill != "" {
            totalBill = Double(bill)!
        }
        let result = Double((totalBill + (tip * totalBill)) / split)
        
        let resultTo2Decimal = String(format: "%.2f", result)
        
       resultTotal = Double(resultTo2Decimal)!
        
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultsViewController
            
            destinationVC.result = resultTotal
            destinationVC.people = Int(split)
            destinationVC.tip = tip
            print(tip)
        }
    }
    

}

