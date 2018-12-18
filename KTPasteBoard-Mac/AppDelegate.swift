//
//  AppDelegate.swift
//  KTPasteBoard-Mac
//
//  Created by Fidetro on 2018/12/12.
//  Copyright © 2018 karim. All rights reserved.
//

import Cocoa
import CloudKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate,KeyboardObserverDelegate {
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)

    var customMenu = NSMenu()
    let obsever = KeyboardObserver.shareInstance()
    var copyCacheString : String = ""
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem.image = NSImage(named:NSImage.Name("StatusBarButtonImage"))
        NSApp.applicationIconImage = NSImage(named: "StatusBarButtonImage")
        obsever.delegate = self

    }
    
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


    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

