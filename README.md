# WCDBSwift
wcdb 的swift 版本简单封装

public static let share: Swift_WXDB_Demo.PGDataBaseManager

    /// 创建表
    /// - Parameter table: n表
    /// - Parameter ttype: 模型类
    internal func createTable<T>(table: String, of ttype: T.Type) where T : WCDBSwift.TableDecodable

    /// 插入
    /// - Parameter objects: 插入模型对象
    /// - Parameter table: 表名
    internal func insertToDB<T>(objects: [T], intoTable table: String) where T : WCDBSwift.TableEncodable

    /// 修改
    /// - Parameter table: 表
    /// - Parameter propertys: 更新字段
    /// - Parameter object: 更新对象
    /// - Parameter condition: 条件
    internal func updateToDB<T>(table: String, on propertys: [PropertyConvertible], with object: T, where condition: Condition? = nil) where T : WCDBSwift.TableEncodable

    /// 删除
    /// - Parameter fromTable: 表
    /// - Parameter condition: 条件
    internal func deleteFromDB(fromTable: String, where condition: Condition? = nil)

    /// 查询
    /// - Parameter fromTable:  表
    /// - Parameter cName: 模型类
    /// - Parameter condition: 条件
    /// - Parameter orderList: 排序
    internal func qureyFromDB<T>(fromTable: String, cls cName: T.Type, where condition: Condition? = nil, orderBy orderList: [OrderBy]? = nil) -> [T]? where T : WCDBSwift.TableDecodable

    /// 删除数据库
    /// - Parameter table: 表
    internal func dropTable(table: String)

    /// 删除相关路径下的所有文件
    internal func removeDBFile()
}
