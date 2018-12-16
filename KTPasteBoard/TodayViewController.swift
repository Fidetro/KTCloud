//
//  TodayViewController.swift
//  KTPasteBoard
//
//  Created by Fidetro on 2018/12/11.
//  Copyright © 2018 karim. All rights reserved.
//

import UIKit
import NotificationCenter
import CloudKit
class TodayViewController: UIViewController, NCWidgetProviding {
    var copyCacheString : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    @IBAction func syncAction(_ sender: UIButton) {
        if let pasteString = UIPasteboard.general.string {
            if copyCacheString != pasteString {
                Cloud.sync(string: pasteString) { [weak self] (_, error) in
                    self?.copyCacheString = pasteString
                    debugPrintLog(error)
                }
            }
        }
    }
    
    
    @IBAction func pullAction(_ sender: UIButton) {
        Cloud.pull { (value) in
            if let value = value as? String {
                UIPasteboard.general.string = value
            }
        }    
    }
    
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
