//
//  KVCloud.swift
//  KTCloud
//
//  Created by Fidetro on 2018/10/30.
//  Copyright © 2018 karim. All rights reserved.
//

import Foundation
import CloudKit
struct KVCloud {
    let publicDatabase = CKContainer.default().publicCloudDatabase
    let recordType : String
    init(recordType:String) {
        self.recordType = recordType
    }
    
    func upsert(key:String,value:Any? , completionHandler:@escaping ((_ record:CKRecord?,_ error:Error?)->())) {
        
        select { (record, error) in
            if let error = error {
                debugPrintLog(error)
                completionHandler(nil,error)
                return
            }
            
            guard let record = record else {
                let newRecord = CKRecord(recordType: self.recordType)
                newRecord.setValue(value, forKey: key)
                self.publicDatabase.save(newRecord, completionHandler: completionHandler)
                self.publicDatabase.save(newRecord) { (record, error) in
                    if let error = error {
                        debugPrintLog(error)
                    }
                    
                }
                return
            }
            record.setValue(value, forKey: key)
            self.publicDatabase.save(record, completionHandler: completionHandler)
        }
        
        
    }
    
    func select(_ completionHandler:((_ record:CKRecord?,_ error:Error?)->())?=nil) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: recordType, predicate: predicate)
        publicDatabase.perform(query, inZoneWith: nil, completionHandler: {
            (results, error) -> Void in
            debugPrintLog(results?.count)
            assert((results?.count ?? 0)<=1)
            
            OperationQueue.main.addOperation {
                if let completionHandler = completionHandler {
                    completionHandler(results?.first,error)
                }
            }
        })
    }
    
    func object(for key:CKRecord.FieldKey, completionHandler : ((__CKRecordObjCValue?)->())?=nil ) {
        select { (record, error) in
            if let completionHandler = completionHandler {
                completionHandler(record?.object(forKey: key))
            }
        }
    }
    
}
