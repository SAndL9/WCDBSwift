//
//  PGDataBaseManager.swift
//  Swift-WXDB-Demo
//
//  Created by 李磊 on 2019/11/4.
//  Copyright © 2019 李磊. All rights reserved.
//

import UIKit
import WCDBSwift
import Foundation
private struct PGBasePath {
    let dbPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask,true).last! + "/PGDB/PGDB.db"
}

public class PGDataBaseManager: NSObject {
   public static let share = PGDataBaseManager.init()
    
   private let dataBasePath = URL.init(fileURLWithPath: PGBasePath.init().dbPath)
   private var dataBase:Database?
   private override init() {
        super.init()
        dataBase = creatDB()
    }
    //创建db
    private func creatDB() ->Database {
        debugPrint(dataBasePath)
        return Database.init(withFileURL: dataBasePath)
    }
    
    
    /// 创建表
    /// - Parameter table: n表
    /// - Parameter ttype: 模型类
    func createTable<T: TableDecodable>(table:String,of ttype:T.Type) -> Void {
        do {
            try dataBase?.create(table: table, of: ttype)
        } catch let error {
            debugPrint("创建失败  \(error.localizedDescription)")
        }
    }
        
    /// 插入
    /// - Parameter objects: 插入模型对象
    /// - Parameter table: 表名
    func insertToDB<T: TableEncodable>(objects:[T],intoTable table:String) -> Void {
        do {
            try dataBase?.insert(objects: objects, intoTable: table)
//            try dataBase?.insertOrReplace(objects: objects, intoTable: table) 主键一直会覆盖
        } catch let error {
            debugPrint("插入失败 \(error.localizedDescription)")
        }
    }
        
    /// 修改
    /// - Parameter table: 表
    /// - Parameter propertys: 更新字段
    /// - Parameter object: 更新对象
    /// - Parameter condition: 条件
    func updateToDB<T:TableEncodable>(table:String,on propertys:[PropertyConvertible],with object:T,where condition: Condition? = nil) -> Void {
        do {
            try dataBase?.update(table: table, on: propertys, with: object,where: condition)
        } catch let error {
            debugPrint("修改失败 \(error.localizedDescription)")
        }
    }
        
    /// 删除
    /// - Parameter fromTable: 表
    /// - Parameter condition: 条件
    func deleteFromDB(fromTable:String,where condition:Condition? = nil) -> Void {
        do {
            try dataBase?.delete(fromTable: fromTable, where:condition)
        } catch let error {
            debugPrint("删除失败 \(error.localizedDescription)")
        }
    }
    
    
    /// 查询
    /// - Parameter fromTable:  表
    /// - Parameter cName: 模型类
    /// - Parameter condition: 条件
    /// - Parameter orderList: 排序
    func qureyFromDB<T:TableDecodable>(fromTable:String,cls cName:T.Type,where condition:Condition? = nil,orderBy orderList:[OrderBy]?=nil) -> [T]? {
        do {
            let allObjects: [T] = try (dataBase?.getObjects(fromTable: fromTable, where:condition, orderBy:orderList))!
            return allObjects
        } catch let error {
            debugPrint("没有找到 \(error.localizedDescription)")
        }
        return nil
    }
 
    
    /// 删除数据库
    /// - Parameter table: 表
    func dropTable(table:String) -> Void {
        do {
            try dataBase?.drop(table: table)
        } catch let error {
            debugPrint("删除表失败 \(error)")
        }
    }
        
    
    /// 删除相关路径下的所有文件
    func removeDBFile() -> Void {
        do {
            try dataBase?.close {
                try dataBase?.removeFiles()
            }
        } catch let error {
            debugPrint("删除相关文件失败 \(error)")
        }
    }
}
