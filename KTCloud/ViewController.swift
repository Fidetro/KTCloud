//
//  ViewController.swift
//  KTCloud
//
//  Created by Fidetro on 2018/10/30.
//  Copyright © 2018 karim. All rights reserved.
//

import UIKit
import CloudKit
class ViewController: UIViewController {
    let cloud = KVCloud(recordType: "KTCloud")
    override func viewDidLoad() {
        super.viewDidLoad()
        

        cloud.upsert(key: "test2", value: "testzaaa") { (_, _) in
            self.cloud.object(for: "test2") { (value) in
                print(value)
            }
        }
        
    }


}

