//
//  ViewController.swift
//  BigNerdRanchProjects
//
//  Created by ahmed ibrahim on 22/02/2022.
//

import UIKit

class ConversionViewController: UIViewController {
    
    @IBOutlet weak var degreeCelciusLbl: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ConversionViewController loaded its view.")
        
        textField.delegate = self
        updateCelciusLabel()
    }
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = generateRandomColor()
    }
    
    let numberFormatter: NumberFormatter = {
       let nf = NumberFormatter()
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        nf.numberStyle = .decimal
        return nf
    }()
    
    var fahrenheitValue: Measurement<UnitTemperature>?{
        didSet{
            updateCelciusLabel()
        }
    }
    var celciusValue: Measurement<UnitTemperature>?{
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        } else {
            return nil
        }
    }
    
    func updateCelciusLabel(){
        if let celciusValue = celciusValue {
            let num = NSNumber(value: celciusValue.value)
            degreeCelciusLbl.text = numberFormatter.string(from: num)
        }else{
            degreeCelciusLbl.text = "???"
        }
    }
    
    @IBAction func txtfieldEditingDidChange(_ textField: UITextField) {
        if let text = textField.text, let number = numberFormatter.number(from: text){
            fahrenheitValue = Measurement(value: number.doubleValue, unit: .fahrenheit)
        }else{
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UIGestureRecognizer) {
        textField.resignFirstResponder()
    }
    
    func generateRandomColor() -> UIColor {
        let redValue = CGFloat(drand48())
        let greenValue = CGFloat(drand48())
        let blueValue = CGFloat(drand48())
        
        let randomColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
        return randomColor
    }
}

extension ConversionViewController: UITextFieldDelegate{
    // big nerd ranch page 132
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // here disallowing letters, only can add numbers
        let disAllowedChars = CharacterSet.letters
        let replacementTextHasLetter = string.rangeOfCharacter(from: disAllowedChars)

        if replacementTextHasLetter != nil{
            return false
        }
        return true
    }
        
        
//        let currentLocale = Locale.current
//        let decimalSeperator = currentLocale.decimalSeparator ?? "."
//        // if existing has decimal point
//        let existingTextHasDecimalSeparator = textField.text?.range(of: decimalSeperator)
//        // if the least also has a decimal point
//        let replacementTextHasDecimalSeparator = string.range(of: decimalSeperator)
//
//        // if both have a decimal point then keep the old and do not accept the new decimal
//        if existingTextHasDecimalSeparator != nil,
//            replacementTextHasDecimalSeparator != nil {
//            return false
//        }
        // given old input (which is correct), when recieves new input, checks to whether to change old input to new input or not (true change, false do not change)
        
        
//    }
}

