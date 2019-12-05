//
//  TodayViewController.swift
//  Calculator Widget
//
//  Created by Dongwoo Pae on 12/5/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet weak var calculatorLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        label.text = "Hello there!"
        mainView.addSubview(label)
        
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
