//
//  Date+Extension.swift
//  AZFunction
//
//  Created by 秦叶 on 2018/9/4.
//  Copyright © 2018年 Aizen. All rights reserved.
//

import Foundation

extension Date{
    
    /// Date -> String
    ///
    /// - Parameter format: 格式
    /// - Returns: 返回类型
    public func az_dateFormat(format:String)->String{
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = format
        let dateStr = dateformatter.string(from: self)
        return dateStr
    }
    
}
