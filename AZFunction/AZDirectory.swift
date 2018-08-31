//
//  AZDirectory.swift
//  AZFunction
//
//  Created by 秦叶 on 2018/8/31.
//  Copyright © 2018年 Aizen. All rights reserved.
//

import Foundation

public class AZDirectory {
    
    //获取documentDirectory路径
    public static func documentDirectory()->String{
        let documentPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,FileManager.SearchPathDomainMask.userDomainMask,true).last! as String
        return documentPath
    }
    
    public static func libDirectory()->String{
        let libtraryPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as String
        return libtraryPath
    }
    
    public static func cacheDirectory()->String{
        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as String
        return cachePath
    }
    
    public static func tmpDirectory()->String{
        let tempPath = NSTemporaryDirectory() as String
        return tempPath
    }
    
}
