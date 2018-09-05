//
//  String+Extension.swift
//  AZFunction
//
//  Created by 秦叶 on 2018/9/5.
//  Copyright © 2018年 Aizen. All rights reserved.
//

import Foundation

extension String{
    
    /// String -> Date
    ///
    /// - Parameter format: 格式
    /// - Returns: date
    public func az_stringToDate(format:String)->Date{
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = format
        let date = dateformatter.date(from: self)
        return date!
    }
   
    /// 时间String之间的格式互相转换
    ///
    /// - Parameters:
    ///   - srcFormat: 原格式
    ///   - toFormat: 目的格式
    /// - Returns: 时间String
    public func az_stringDateFormat(srcFormat:String, toFormat:String)->String{
        let date = self.az_stringToDate(format: srcFormat)
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = toFormat
        let dateStr = dateformatter.string(from: date)
        return dateStr
    }
    
    
    
}
