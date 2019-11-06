//
//  Sample.swift
//  Swift-WXDB-Demo
//
//  Created by 李磊 on 2019/11/4.
//  Copyright © 2019 李磊. All rights reserved.
//

import UIKit
import WCDBSwift
import Foundation

class Sample: TableCodable {
    var name:String? = nil
    var age: Int = 0
    var sex:Bool = false
    var show_id:Int64 = 0
    var description: String? = nil
    var dd:Int = 0

    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = Sample
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        case description
        case name
        case age
        case sex
        case show_id
        
        
        static var columnConstraintBindings: [Sample.CodingKeys : ColumnConstraintBinding]?{
            return [
                show_id:ColumnConstraintBinding(isPrimary: true)
            ]
        }
        
        
        
        /*
         ColumnConstraintBinding(
         isPrimary: <#T##Bool#>,该字段是否为主键
         orderBy: <#T##OrderTerm?#>,当该字段是主键的时,存储顺序是升序还是降序
         isAutoIncrement: <#T##Bool#>,当该字段是主键时,其是否支持自增。只有整型数据可以定义为自增
         onConflict: <#T##Conflict?#>,当该字段是主键时，a若产生冲突, 该如何处理
         isNotNull: <#T##Bool#>,该字段是否可以为空
         isUnique: <#T##Bool#>,该字段是否可以具有唯一性
         defaultTo: <#T##ColumnEncodable#>)该字段在数据库内使用什么默认值

         */
        
        
    }

}
