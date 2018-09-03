//
//  AZDebug.swift
//  AZFunction
//
//  Created by 秦叶 on 2018/9/3.
//  Copyright © 2018年 Aizen. All rights reserved.
//

import Foundation

public func print_debug<T>(message:T, fileName:String = #file, methodName:String = #function, lineNumber:Int = #line){
    #if DEBUG
    let fileStr : String = (fileName as NSString).pathComponents.last!.replacingOccurrences(of: "swift", with: "")
    print("\(fileStr)\(methodName)[\(lineNumber)]:\(message)")
    #endif
}
