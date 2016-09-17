//
//  ViewController.swift
//  Calculator
//
//  Created by CongTruong on 9/11/16.
//  Copyright © 2016 congtruong. All rights reserved.
//

import UIKit

extension UIPanGestureRecognizer {
    func isLeft(theViewYouArePassing: UIView) -> Bool {
        let velocity : CGPoint = velocityInView(theViewYouArePassing)
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
    
    override func viewWillAppear(animated: Bool) {
        let defaults = NSUserDefaults.standardUserDefaults()
        if let firstValue = defaults.objectForKey("firstSegment") as? Int {
            tipPersentages[0] = firstValue
            tipControl.setTitle("\(firstValue)%", forSegmentAtIndex: 0)
        }
        if let secondValue = defaults.objectForKey("secondSegment") as? Int {
            tipPersentages[1] = secondValue
            tipControl.setTitle("\(secondValue)%", forSegmentAtIndex: 1)
        }
        if let thirdValue = defaults.objectForKey("thirdSegment") as? Int {
            tipPersentages[2] = thirdValue
            tipControl.setTitle("\(thirdValue)%", forSegmentAtIndex: 2)
        }
        
        self.calculate(billTextField)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(sender: AnyObject) {
        self.view.endEditing(true)
    }

    @IBAction func calculate(sender: AnyObject) {
        let bill = Double(billTextField.text!) ?? 0
        let tip = bill * Double(tipPersentages[tipControl.selectedSegmentIndex]) / 100
        let total = bill + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    @IBAction func panChangeSegmentValue(sender: UIPanGestureRecognizer) {
        
        let value = tipPersentages[tipControl.selectedSegmentIndex]
        if sender.isLeft(self.view) {
            if tipPersentages[tipControl.selectedSegmentIndex] > 0 {
                // down value
                tipPersentages[tipControl.selectedSegmentIndex] = value - 1
                tipControl.setTitle("\(value - 1)%", forSegmentAtIndex: tipControl.selectedSegmentIndex)
            }
        }
        else {
            if tipPersentages[tipControl.selectedSegmentIndex] < 100 {
                // up value
                tipPersentages[tipControl.selectedSegmentIndex] = value + 1
                tipControl.setTitle("\(value + 1)%", forSegmentAtIndex: tipControl.selectedSegmentIndex)
            }
        }
        
        self.calculate(billTextField)
    }
    
    
}

