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
        firstSegmentTextField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveSettings(_ sender: AnyObject) {
        
        let handleSaving = { (alertAction: UIAlertAction) -> () in
            self.saveSettings()
            self.navigationController?.popViewController(animated: true)
        }
        
        if Int(firstSegmentTextField.text!) == nil
            || Int(secondSegmentTextField.text!) == nil
            || Int(thirdSegmentTextField.text!) == nil {
            
            let alert = UIAlertController(title: "Message", message: "You have empty cell, i will fill default value", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.default, handler: handleSaving))
            self.present(alert, animated: true, completion: nil)
        }
        
        self.saveSettings()
        self.navigationController?.popViewController(animated: true)
    }
    
    func saveSettings() {
        
        valueSegment.first = Int(firstSegmentTextField.text!) ?? 18
        valueSegment.second = Int(secondSegmentTextField.text!) ?? 20
        valueSegment.third = Int(thirdSegmentTextField.text!) ?? 30
        
        if !checkValid(value: valueSegment.first)
            || !checkValid(value: valueSegment.second)
            || !checkValid(value: valueSegment.third) {
            
            let alert = UIAlertController(title: "Message", message: "Please input value minimum is 0 and maximum is 100", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        let defaults = UserDefaults.standard
        defaults.set(valueSegment.first, forKey: "firstSegment")
        defaults.set(valueSegment.second, forKey: "secondSegment")
        defaults.set(valueSegment.third, forKey: "thirdSegment")
        defaults.synchronize()
    }
    
    func checkValid(value: Int) -> Bool {
        
        if value < 0 || value > 100 {
            return false
        }
        return true
    }
}
