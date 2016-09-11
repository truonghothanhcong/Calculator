//
//  ViewController.swift
//  Calculator
//
//  Created by CongTruong on 9/11/16.
//  Copyright © 2016 congtruong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    var tipPersentages = [0.18, 0.2, 0.3]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        let defaults = NSUserDefaults.standardUserDefaults()
        if let firstValue = defaults.objectForKey("firstSegment") as? Int {
            tipPersentages[0] = Double(firstValue) / 100
            tipControl.setTitle("\(firstValue)%", forSegmentAtIndex: 0)
        }
        if let secondValue = defaults.objectForKey("secondSegment") as? Int {
            tipPersentages[1] = Double(secondValue) / 100
            tipControl.setTitle("\(secondValue)%", forSegmentAtIndex: 1)
        }
        if let thirdValue = defaults.objectForKey("thirdSegment") as? Int {
            tipPersentages[2] = Double(thirdValue) / 100
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
        let tip = bill * tipPersentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
}

