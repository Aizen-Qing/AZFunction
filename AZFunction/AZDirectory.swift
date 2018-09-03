//
//  AZDirectory.swift
//  AZFunction
//
//  Created by 秦叶 on 2018/8/31.
//  Copyright © 2018年 Aizen. All rights reserved.
//

import Foundation

public class AZDirectory {
    
    @discardableResult
    //获取documentDirectory路径
    public static func documentDirectory()->String{
        let documentPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,FileManager.SearchPathDomainMask.userDomainMask,true).last! as String
        return documentPath
    }
    
    //获取documentDirectory路径
    public static func libraryDirectory()->String{
        let libtraryPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as String
        return libtraryPath
    }
    
    //获取cachesDirectory路径
    public static func cacheDirectory()->String{
        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as String
        return cachePath
    }
    
    //获取tempDirectory路径
    public static func tmpDirectory()->String{
        let tempPath = NSTemporaryDirectory() as String
        return tempPath
    }
    
    
    
    //文件夹的检查
    public static func isfileExists(path:String)->Bool{
        let  fileManager = FileManager.default
        let result = fileManager.fileExists(atPath: path)
        return result;
    }
    
    
    // 创建文件夹 存在返回true 不存在返回false
    public static func creatDirectoryPath(path:String)->Bool{
        if path.isEmpty { return false }
        
        let  fileManager = FileManager.default
        if !self.isfileExists(path: path) {
            do{
                try fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
                return true
            } catch{
                return false
            }
        }else{
            return true
        }
    }
 
    /// 创建文件夹 若是有文件则更改名称直到创建成功
    ///
    /// - Parameters:
    ///   - path: path
    ///   - name: 文件名称
    /// - Returns: 最终文件名称
    public static func createDirectoryLegal(path:String, name:String, type:String)->Any?{
        if path.isEmpty || name.isEmpty { return nil }
        
        let  fileManager = FileManager.default
        let filePath = self._legalFile(path: path, name: name, type: type, index: 0)
        do{
            try fileManager.createDirectory(atPath: filePath as! String, withIntermediateDirectories: true, attributes: nil)
            return filePath
        } catch{
            return nil
        }
    }
    
    
    //创建文件
    public static func creatFilePath(path:String, data:Data)->Bool{
        if path.isEmpty { return false }
        let  fileManager = FileManager.default
        if self.isfileExists(path: path) {
            fileManager.createFile(atPath: path, contents: data, attributes: nil)
            return true
        }else{
            return true
        }
    }
    
    //创建文件
    public static func creatFilePath(path:String, name:String, type:String, data:Data)->Any?{
        if path.isEmpty || name.isEmpty { return nil }
        let  fileManager = FileManager.default
        let filePath = self._legalFile(path: path, name: name, type: type, index: 0)
        if filePath == nil { return nil }
        fileManager.createFile(atPath: path, contents: data, attributes: nil)
        return filePath
    }

  
    // 文件复制
    public static func copyFile(scrPath:String, toPath:String)->Bool{
        let fileManager = FileManager.default
        do{
            try fileManager.copyItem(atPath: scrPath, toPath: toPath)
            return true
        } catch{
            return false
        }
    }
    
    
    //文件移动
    public static func moveFile(scrPath:String, toPath:String)->Bool{
        let fileManager = FileManager.default
        do{
            try fileManager.moveItem(atPath: scrPath, toPath: toPath)
            return true
        } catch{
            return false
        }
    }
    
    
    
    //文件删除
    public static func deleteFile(path:String)->Bool{
        let fileManager = FileManager.default
        do{
            try fileManager.removeItem(atPath: path)
            return true
        } catch{
            return false
        }
    }

    
    
    //MARK:- 私有文件
    
    /// 获取检测文件名
    ///
    /// - Parameters:
    ///   - path: 路径
    ///   - name: 文件名称
    ///   - type: 类型
    ///   - index: index
    /// - Returns: 最终路径
    private static func _legalFile(path:String, name:String, type:String, index:Int)->Any?{
        if path.isEmpty || name.isEmpty { return nil }
        
        var indexStr = ""
        if index != 0 { indexStr = "-"+String(index) }
        let filePath = path + name + indexStr + type
        if self.isfileExists(path: filePath) {
            let tIndex = index+1
            return self._legalFile(path:path, name:name, type:type, index:tIndex)
        }else{
            return filePath
        }
    }
    
}
