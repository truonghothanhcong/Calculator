//
//  SetttingViewController.swift
//  Calculator
//
//  Created by CongTruong on 9/11/16.
//  Copyright © 2016 congtruong. All rights reserved.
//

import UIKit

class SetttingViewController: UIViewController {
    
    var valueSegment = (first: 0, second: 0, third: 0)
    @IBOutlet weak var firstSegmentTextField: UITextField!
    @IBOutlet weak var secondSegmentTextField: UITextField!
    @IBOutlet weak var thirdSegmentTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveSettings(sender: AnyObject) {
        valueSegment.first = Int(firstSegmentTextField.text!) ?? 0
        valueSegment.second = Int(secondSegmentTextField.text!) ?? 0
        valueSegment.third = Int(thirdSegmentTextField.text!) ?? 0
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(valueSegment.first, forKey: "firstSegment")
        defaults.setInteger(valueSegment.second, forKey: "secondSegment")
        defaults.setInteger(valueSegment.third, forKey: "thirdSegment")
        defaults.synchronize()
        
        self.navigationController?.popViewControllerAnimated(true)
    }
}
