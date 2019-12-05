//
//  TodayViewController.swift
//  Calculator Widget
//
//  Created by Dongwoo Pae on 12/5/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit
import NotificationCenter
import RNP

class TodayViewController: UIViewController, NCWidgetProviding, UITextFieldDelegate {

    @IBOutlet weak var calculatorLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    
    //stored properties n
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.allowsFloats = true
        formatter.maximumIntegerDigits = 20
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 20
        return formatter
    }()
    
    private var calculator = Calculator() {
        didSet {
            if let value = calculator.topValue {
                textField.text = numberFormatter.string(from: value as NSNumber)  //object wrapper around the number
            } else {
                textField.text = ""
            }
        }
    }
    
    private var digitAccumulator = DigitAccumulator() {
        didSet {
            if let value = digitAccumulator.value() {
                textField.text = numberFormatter.string(from: value as NSNumber)
            } else {
                textField.text = ""
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textField.delegate = self
        extensionContext?.widgetLargestAvailableDisplayMode = .expanded
    }
    
    @IBAction func numberButtonTapped(_ sender: UIButton) {
        try? digitAccumulator.add(digit: .number(sender.tag))
    }
    
    @IBAction func decimalButtonTapped(_ sender: UIButton) {
        try? digitAccumulator.add(digit: .decimalPoint)
    }
    
    @IBAction func returnButtonTapped(_ sender: UIButton) {
        //take the value from the accumulator and push it to the stack
        if let value = digitAccumulator.value() {
            calculator.push(number: value)
        }
        digitAccumulator.clear()
    }
    
    @IBAction func divideButtonTapped(_ sender: UIButton) {
        calculator.push(operator: .divide)
    }
    @IBAction func multiplyButtonTapped(_ sender: UIButton) {
        calculator.push(operator: .multiply)
    }
    @IBAction func subtractButtonTapped(_ sender: UIButton) {
        calculator.push(operator: .subtract)
    }
    @IBAction func plusButtonTapped(_ sender: UIButton) {
        calculator.push(operator: .add)
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        calculator.clear()
        digitAccumulator.clear()
        return true
    }

    
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        
        
        completionHandler(NCUpdateResult.newData)
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        switch activeDisplayMode {
        case .compact:
            preferredContentSize = maxSize
        case .expanded:
            preferredContentSize = CGSize(width: maxSize.width, height: 330)
        @unknown default:
            break
        }
    }
    
    @IBAction func copyInput(_ sender: Any) {
        UIPasteboard.general.string = textField.text
    }
}

