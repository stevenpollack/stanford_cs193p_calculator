//
//  ViewController.swift
//  Calculator
//
//  Created by user on 29/06/16.
//  Copyright © 2016 gnobel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // from UIViewController
    
    
    @IBOutlet private weak var display: UILabel!
    
    private var userIsTyping = false
    
    // set up a calculated property to hold display
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsTyping {
            display.text = display.text! + digit
        } else {
            display.text = digit
        }
        
        userIsTyping = true
    }
    
    @IBAction func modifyMemory(_ sender: UIButton) {
        /*
        M+/- == memory add or subtract
         MC == memory clear
         MR == memory recall
 */
    }
    @IBAction private func clearDisplay(_ sender: UIButton) {
        displayValue = 0
        userIsTyping = false
    }
    
    @IBAction private func storeInMemory(_ sender: UIButton) {
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if userIsTyping {
            brain.setOperand(displayValue)
            userIsTyping = false
        }
        
        if let mathOp = sender.currentTitle {
            brain.performOperation(mathOp)
        }
        
        displayValue = brain.result
        
    }
}

