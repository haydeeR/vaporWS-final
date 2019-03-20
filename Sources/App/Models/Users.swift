import FluentSQLite
import Vapor

final class Users: SQLiteModel{
    var id: Int?
    var name: String
    
    init(id: Int?, name: String){
        self.id = id
        self.name = name
    }
}

extension Users: Content {}
extension Users: Migration {}
extension Users: Parameter {}
