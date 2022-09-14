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
            degreeCelciusLbl.text = numberFormatter.string(from: NSNumber(value: celciusValue))
        }else{
            degreeCelciusLbl.text = "???"
        }
    }
    
    @IBAction func txtfieldEditingDidChange(_ textField: UITextField) {
        if let text = textField.text, let value = Double(text){
            fahrenheitValue = Measurement(value: value, unit: .fahrenheit)
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

