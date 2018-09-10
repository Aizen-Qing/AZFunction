//
//  AZRouter.swift
//  AZFunction
//
//  Created by 秦叶 on 2018/9/1.
//  Copyright © 2018年 Aizen. All rights reserved.
//

import Foundation
import UIKit

public class AZRouter {
    
    @discardableResult
    public static func perform(spaceName:String, targetName: String, actionName: String? = nil, parameters: [String: Any]? = nil) -> Any? {
        
        guard let target: AnyObject  = NSClassFromString(spaceName+"."+targetName) else {return nil}
        
        if actionName == nil {//无方法时操作
            
            guard let clsType = target as? NSObject.Type else {return nil}
            let obj = clsType.init()
            return obj
            
        }else{
            
            let action = NSSelectorFromString(actionName!)
            if target.responds(to: action) {//调用方法为@objc类方法
                return target.perform(action, with:parameters).takeUnretainedValue()
            }  else {
                return nil
            }
            
        }
    }
    
}
