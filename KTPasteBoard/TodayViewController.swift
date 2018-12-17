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

    
    lazy var syncButton: PasteButton = {
        var syncButton = PasteButton()
        syncButton.titleLabel.text = "同步"
        syncButton.addTarget(self, action: #selector(syncAction(_:)), for: .touchUpInside)
        return syncButton
    }()
    
    lazy var pullButton: PasteButton = {
        var pullButton = PasteButton()
        pullButton.titleLabel.text = "拉取"
        pullButton.addTarget(self, action: #selector(pullAction(_:)), for: .touchUpInside)
        return pullButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        snpLayoutSubview()
    }
    
    func snpLayoutSubview() {
        view.addSubview(syncButton)
        view.addSubview(pullButton)
        syncButton.snp.makeConstraints{
            $0.left.equalTo(10)
            $0.centerY.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5).offset(-20)
            $0.height.equalTo(44)
        }        
        pullButton.snp.makeConstraints{
            $0.right.equalTo(-10)
            $0.centerY.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5).offset(-20)
            $0.height.equalTo(44)
        }
    }
        
    @objc func syncAction(_ sender: PasteButton) {
        sender.updateStatus(.selected)
        guard let pasteString = UIPasteboard.general.string,copyCacheString != pasteString else {
            sender.updateStatus(.normal)
            return
        }
        Cloud.sync(string: pasteString) { [weak self] (_, error) in
            self?.copyCacheString = pasteString
            debugPrintLog(error)
            sender.updateStatus(.normal)
            
        }
    }
    
    
    @objc func pullAction(_ sender: PasteButton) {
        sender.updateStatus(.selected)
        Cloud.pull { (value) in
            if let value = value as? String {
                UIPasteboard.general.string = value
            }
            sender.updateStatus(.normal)
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
