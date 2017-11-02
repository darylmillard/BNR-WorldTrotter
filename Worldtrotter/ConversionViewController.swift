//
//  ConversionViewController.swift
//  Worldtrotter
//
//  Created by Daryl Millard on 9/26/17.
//  Copyright © 2017 Daryl Millard. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    var fahrenheitValue: Measurement<UnitTemperature>? {
        didSet {
            updateCelciusLabel()
        }
    }
    
    var celsiusValue: Measurement<UnitTemperature>? {
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        } else {
            return nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ConversionViewController loaded it's view.")
        
        updateCelciusLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let calendar = NSCalendar.current
        let hour = calendar.component(.hour, from: NSDate() as Date)
        
        let dayColor = UIColor(red: 0xF5/255, green: 0xF4/255, blue: 0xF1/255, alpha: 1)
        let nightColor = UIColor(red: 0x4b/255, green: 0x54/255, blue: 0x57/255, alpha: 1)
        
        // sets the background color based on time of day
        if hour >= 8 && hour <= 20 {
            self.view.backgroundColor = dayColor
        } else {
            self.view.backgroundColor = nightColor
        }
    }
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    } ()
    
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField) {
        if let text = textField.text, let value = Double(text) {
            fahrenheitValue = Measurement(value: value, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }
        
    }
    func updateCelciusLabel() {
        if let celsiusValue = celsiusValue {
            celsiusLabel.text =
                numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        } else {
            celsiusLabel.text = "???"
        }
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let existingTextHasDecimalSeparator = textField.text?.range( of: ".")
        let replacementTextHasDecimalSeparator = string.range( of: ".")
        
        let charactersNotAllowed = NSCharacterSet.letters
        let replacementTextHasLetter = string.rangeOfCharacter(from: charactersNotAllowed)
        
        if existingTextHasDecimalSeparator != nil, replacementTextHasDecimalSeparator != nil{
            if replacementTextHasLetter != nil{
                return false
            }
            return false
        } else {
            if replacementTextHasLetter != nil{
                return false
            }
            return true
        }
    }
    
    
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
}
