//
//  Cloud.swift
//  KTCloud
//
//  Created by Fidetro on 2018/10/30.
//  Copyright © 2018 karim. All rights reserved.
//

import Foundation
import CloudKit

struct Cloud {
   static let cloud = KVCloud(container: CKContainer(identifier: "iCloud.com.karim.KTCloud"), recordType: "KTCloud")
   static let pasteKey = "Pasteboard"
    
    static func sync(string: String, completion completionHandler: @escaping ((_ record:CKRecord?,_ error:Error?)->())) {
        CKContainer.init(identifier: "")
        cloud.upsert(key: pasteKey, value: string, completionHandler: completionHandler)
    }
    
    static func pull(completion completionHandler: ((__CKRecordObjCValue?)->())?=nil) {
        cloud.object(for: pasteKey, completionHandler: completionHandler)
    }
}
