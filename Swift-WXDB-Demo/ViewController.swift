//
//  ViewController.swift
//  Swift-WXDB-Demo
//
//  Created by 李磊 on 2019/11/4.
//  Copyright © 2019 李磊. All rights reserved.
//

import UIKit
import WCDBSwift
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        // Do any additional setup after loading the view.
        PGDataBaseManager.share.createTable(table: "lilei", of: Sample.self)
        let a = Sample.init()
        a.age  = 11
        a.name = "zhangsan"
        a.description = "这是测试数据的"
        a.show_id = 1232

        let b = Sample.init()
        b.age = 90
        b.name = "李四"
        b.description = "这是李四的c数据存储s"
        b.sex = true
        
        
        let c = Sample.init()
        c.age = 56
        c.name = "王五"
        c.description = "这是王五的描述"
        c.show_id = 177293
        
        
        
        let d =  Sample.init()
        d.age = 77
        d.name = "小刘"
        d.description = "这是小刘的信息介绍库"
        d.show_id = 177299
        
        //插入
        PGDataBaseManager.share.insertToDB(objects: [a,b,c,d], intoTable: "lilei")
        debugPrint("-------------------插入数据--------------------")
        getAllObject()
        
        
        
        debugPrint("-----按照条件查找---Sample.Properties.age > 18 && Sample.Properties.show_id > 17729------")
       //根据条件查找
       let arr:[Sample] = PGDataBaseManager.share.qureyFromDB(fromTable: "lilei", cls: Sample.self, where: Sample.Properties.age > 18 && Sample.Properties.show_id > 177292, orderBy: [Sample.Properties.age.asOrder()]) ?? Array.init()
       
//       debugPrint(arr)
       for w in arr {
           debugPrint(w.age)
       }
        
      
        
        
        //更新
        let update1 = Sample.init()
        update1.name = "laoli"
        update1.age = 66

        PGDataBaseManager.share.updateToDB(table: "lilei", on: [Sample.Properties.name], with: update1)
        PGDataBaseManager.share.updateToDB(table: "lilei", on: [Sample.Properties.age,Sample.Properties.name], with: update1, where: Sample.Properties.age > 11)
        debugPrint("-------------------更新数据--Sample.Properties.age > 11--名字改为laoli--age改为66---------")
        getAllObject()

        
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        PGDataBaseManager.share.deleteFromDB(fromTable: "lilei")
        PGDataBaseManager.share.deleteFromDB(fromTable: "lilei", where: Sample.CodingKeys.age > 6)
        PGDataBaseManager.share.removeDBFile()
    
    }
    
    
    func getAllObject() -> Void {
        //全部查找
        let array:[Sample] = PGDataBaseManager.share.qureyFromDB(fromTable: "lilei", cls: Sample.self) ?? Array.init()
                
        for aw in array {
            debugPrint(aw.age,aw.name ?? "名字",aw.show_id)
        }
        debugPrint("------------------------------------------------")
    }
    
}

