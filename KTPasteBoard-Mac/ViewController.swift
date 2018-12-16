//
//  ViewController.swift
//  KTPasteBoard-Mac
//
//  Created by Fidetro on 2018/12/12.
//  Copyright © 2018 karim. All rights reserved.
//

import Cocoa
import CloudKit
class ViewController: NSViewController,KeyboardObserverDelegate {

    
    let obsever = KeyboardObserver.shareInstance()
    var copyCacheString : String = ""
    
    func keyboardChange(withInputedString inputedString: String, flag: CGEventFlags) {
        
        if inputedString.lowercased() == "c",(flag.rawValue & CGEventFlags.maskSecondaryFn.rawValue) > 0x0 {
            
            if let string = NSPasteboard.general.string(forType: .string) {
                if copyCacheString != string {
                    Cloud.sync(string: string) { [weak self] (_, error) in
                        self?.copyCacheString = string
                        debugPrintLog(error)
                    }
                }
            }
        }else if inputedString.lowercased() == "t",(flag.rawValue & CGEventFlags.maskSecondaryFn.rawValue) > 0x0 {
            Cloud.pull { (value) in
                if let value = value as? String {
                    NSPasteboard.general.clearContents()
                    NSPasteboard.general.setString(value, forType: .string)
                    NSPasteboard.general.string(forType: .string)
                }
            }
        }
        
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        obsever.delegate = self

    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

