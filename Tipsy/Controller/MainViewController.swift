//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tipPct: Int = 10
    var split: Int = 2
    var perPersonSplit = Float(0.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tenPctButton.isSelected = true
    }

    @IBAction func tipChanged(_ sender: UIButton) {
        unselectAllPctButton()
        billTextField.endEditing(true)
        if sender.currentTitle == "0%"{
            zeroPctButton.isSelected = true
            tipPct = 0
        }else if sender.currentTitle == "10%"{
            tenPctButton.isSelected = true
            tipPct = 10
        }else{
            twentyPctButton.isSelected = true
            tipPct = 20
        }
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        split = Int(sender.value)
        splitNumberLabel.text = "\(split)"
        
    }
    @IBAction func calculatePressed(_ sender: UIButton) {
        if let billAmount = Float(billTextField.text!) {
            perPersonSplit = (((Float(tipPct)/Float(100))*billAmount)+billAmount)/Float(split)
            
        }else{
            print("Invalid input")
        }
    }
    
    func unselectAllPctButton(){
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "resultSegway"{
            let controller = segue.destination as! ResultViewController
            controller.total = "\(perPersonSplit)"
            controller.settings = "Split between \(split) people with \(tipPct)% tip."
        }
    }
}

