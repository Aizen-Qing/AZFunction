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
    @discardableResult
    public static func documentDirectory()->String{
        let documentPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,FileManager.SearchPathDomainMask.userDomainMask,true).last! as String
        return documentPath
    }
    
    //获取documentDirectory路径
    @discardableResult
    public static func libraryDirectory()->String{
        let libtraryPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as String
        return libtraryPath
    }
    
    //获取cachesDirectory路径
    @discardableResult
    public static func cacheDirectory()->String{
        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as String
        return cachePath
    }
    
    //获取tempDirectory路径
    @discardableResult
    public static func tmpDirectory()->String{
        let tempPath = NSTemporaryDirectory() as String
        return tempPath
    }
    
    
    
    //文件的检查
    @discardableResult
    public static func isfileExists(path:String)->Bool{
        if path.isEmpty { return false }
        let  fileManager = FileManager.default
        let result = fileManager.fileExists(atPath: path)
        return result;
    }
    
    
    // 创建文件夹 存在返回true 不存在返回false
    @discardableResult
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
    @discardableResult
    public static func createDirectoryLegal(path:String, name:String, type:String)->Any?{
        if path.isEmpty || name.isEmpty { return nil }
        
        let  fileManager = FileManager.default
        let filePath = self._legalFile(path: path, name: name, type: type, index: 0)
        if filePath == nil { return nil }
        do{
            try fileManager.createDirectory(atPath: filePath as! String, withIntermediateDirectories: true, attributes: nil)
            return filePath
        } catch{
            return nil
        }
    }
    
    
    //创建文件
    @discardableResult
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
    @discardableResult
    public static func creatFilePathLegal(path:String, name:String, type:String, data:Data)->Any?{
        if path.isEmpty || name.isEmpty { return nil }
        let  fileManager = FileManager.default
        let filePath = self._legalFile(path: path, name: name, type: type, index: 0)
        if filePath == nil { return nil }
        fileManager.createFile(atPath: path, contents: data, attributes: nil)
        return filePath
    }

  
    // 文件复制
    @discardableResult
    public static func copyFile(scrPath:String, toPath:String)->Bool{
        if scrPath.isEmpty || toPath.isEmpty { return false }
        let fileManager = FileManager.default
        do{
            try fileManager.copyItem(atPath: scrPath, toPath: toPath)
            return true
        } catch{
            return false
        }
    }
    
    
    //文件移动
    @discardableResult
    public static func moveFile(scrPath:String, toPath:String)->Bool{
        if scrPath.isEmpty || toPath.isEmpty { return false }
        let fileManager = FileManager.default
        do{
            try fileManager.moveItem(atPath: scrPath, toPath: toPath)
            return true
        } catch{
            return false
        }
    }
    
    // legal 文件移动
    @discardableResult
    public static func moveFileLegal(scrPath:String, toPath:String)->Any?{
        
        if scrPath.isEmpty || toPath.isEmpty { return false }
        let fileManager = FileManager.default
        var path : String
        
        let urlPath = URL.init(string: toPath)
        var fileName = urlPath?.lastPathComponent
        
        if self.isfileExists(path: toPath) {
            var type = Optional<Any>.none
            if !self.isDirectory(path: toPath){
                let arr = fileName?.components(separatedBy: ".")
                if (arr?.count)!>1{
                    type = arr?.last
                    let str : String = fileName!
                    fileName = (fileName! as NSString).substring(with: NSMakeRange(0, str.count-(type as! String).count-1))
                }
            }
            let tmpPath = self._legalFile(path: toPath, name: fileName!, type: type as! String, index: 0)
            if tmpPath == nil { return nil }
            else { path = tmpPath as! String }
        }else{
            path = toPath
        }
        
        do{
            try fileManager.moveItem(atPath: scrPath, toPath: path)
            return toPath
        } catch{
            return nil
        }
    }
    
    
    
    //文件删除
    @discardableResult
    public static func deleteFile(path:String)->Bool{
        if path.isEmpty { return false }
        let fileManager = FileManager.default
        do{
            try fileManager.removeItem(atPath: path)
            return true
        } catch{
            return false
        }
    }

    //遍历文件目录
    public static func allDirectory(path:String)->[String]{
        let fileManager = FileManager.default
        let itemArr = try? fileManager.subpathsOfDirectory(atPath: path)
        return itemArr!
    }
    
    //判断是文件还是文件夹
    public static func isDirectory(path:String)->Bool{
        if path.isEmpty { return false }
        let fileManager = FileManager.default
        var isDirectory : ObjCBool = false
        fileManager.fileExists(atPath: path, isDirectory: &isDirectory)
        return isDirectory.boolValue
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
        let filePath = path + name + indexStr + "." + type
        if self.isfileExists(path: filePath) {
            let tIndex = index+1
            return self._legalFile(path:path, name:name, type:type, index:tIndex)
        }else{
            return filePath
        }
    }
    
}
