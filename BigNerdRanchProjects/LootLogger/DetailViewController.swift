//
//  DetailViewController.swift
//  BigNerdRanchProjects
//
//  Created by Ahmad medo on 17/09/2022.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var serialTxtField: UITextField!
    @IBOutlet weak var valueTxtField: UITextField!
    @IBOutlet weak var dateLbl: UILabel!

    var item: Item!
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameTxtField.text = item.name
        serialTxtField.text = item.serialNumber
        valueTxtField.text = numberFormatter.string(from: NSNumber(value: item.valueInDollars))
        dateLbl.text = dateFormatter.string(from: item.dateCreated)
    }
    
}
