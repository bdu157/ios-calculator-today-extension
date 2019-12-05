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

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet weak var calculatorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        extensionContext?.widgetLargestAvailableDisplayMode = .expanded
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
    
}

