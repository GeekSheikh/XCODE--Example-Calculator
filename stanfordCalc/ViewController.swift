//
//  ViewController.swift
//  stanfordCalc
//
//  Created by Daniel Tomes on 12/25/16.
//  Copyright © 2016 Daniel Tomes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    private var userIsInTheMiddleOfTyping = false
    private var displayValue: Double {
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(brain.result)
        }
    }
    private var brain = CalculatorBrain()
    
    @IBOutlet private weak var display: UILabel!
    
    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
        }
        userIsInTheMiddleOfTyping = true
    }
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(operand: displayValue)
            userIsInTheMiddleOfTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(symbol: mathematicalSymbol)
        }
        displayValue = brain.result
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

