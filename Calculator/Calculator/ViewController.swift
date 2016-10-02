//
//  ViewController.swift
//  Calculator
//
//  Created by CongTruong on 9/11/16.
//  Copyright © 2016 congtruong. All rights reserved.
//

import UIKit

extension UIPanGestureRecognizer {
    func isLeft(_ theViewYouArePassing: UIView) -> Bool {
        let velocity : CGPoint = self.velocity(in: theViewYouArePassing)
        if velocity.x > 0 {
            return false
        } else {
            return true
        }
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    var tipPersentages = [18, 20, 30]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.view.alpha = 0
        UIView.animate(withDuration: 0.4, animations: {
            // This causes first view to fade in and second view to fade out
                self.view.alpha = 1
        })
        
        // show keyboard
        billTextField.becomeFirstResponder()
        
        // load data
        let defaults = UserDefaults.standard
        if let billValue = defaults.object(forKey: "bill") as? String {
            billTextField.text = billValue
        }
        if let firstValue = defaults.object(forKey: "firstSegment") as? Int {
            tipPersentages[0] = firstValue
            tipControl.setTitle("\(firstValue)%", forSegmentAt: 0)
        }
        if let secondValue = defaults.object(forKey: "secondSegment") as? Int {
            tipPersentages[1] = secondValue
            tipControl.setTitle("\(secondValue)%", forSegmentAt: 1)
        }
        if let thirdValue = defaults.object(forKey: "thirdSegment") as? Int {
            tipPersentages[2] = thirdValue
            tipControl.setTitle("\(thirdValue)%", forSegmentAt: 2)
        }
        
        self.calculate(billTextField)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: AnyObject) {
        self.view.endEditing(true)
    }

    @IBAction func calculate(_ sender: AnyObject) {
        let bill = Double(billTextField.text!) ?? 0
        let tip = bill * Double(tipPersentages[tipControl.selectedSegmentIndex]) / 100
        let total = bill + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        
        // saving bill
        let defaults = UserDefaults.standard
        defaults.set(billTextField.text, forKey: "bill")
        defaults.synchronize()
    }
    
    @IBAction func panChangeSegmentValue(_ sender: UIPanGestureRecognizer) {
        
        let value = tipPersentages[tipControl.selectedSegmentIndex]
        if sender.isLeft(self.view) {
            if tipPersentages[tipControl.selectedSegmentIndex] > 0 {
                // down value
                tipPersentages[tipControl.selectedSegmentIndex] = value - 1
                tipControl.setTitle("\(value - 1)%", forSegmentAt: tipControl.selectedSegmentIndex)
            }
        }
        else {
            if tipPersentages[tipControl.selectedSegmentIndex] < 100 {
                // up value
                tipPersentages[tipControl.selectedSegmentIndex] = value + 1
                tipControl.setTitle("\(value + 1)%", forSegmentAt: tipControl.selectedSegmentIndex)
            }
        }
        
        self.calculate(billTextField)
    }
    
    
}

