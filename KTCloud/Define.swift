//
//  Define.swift
//  Define
//
//  Created by Fidetro on 21/12/2017.
//  Copyright © 2017 Fidetro. All rights reserved.
//



func debugPrintLog<T>(_ message: T,
                      file: String = #file,
                      method: String = #function,
                      line: Int = #line)
{
    assert({ print("\(file)[\(line)], \(method): \(message)"); return true }())
}


func debugCode(_ body: () -> Void) {
    assert({ body(); return true }())
}


