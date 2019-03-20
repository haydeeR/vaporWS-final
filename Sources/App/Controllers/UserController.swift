import Vapor

final class UserController {
    
    func list (_ req: Request) throws -> Future<View> {
     return Users.query(on: req).all().flatMap{ users in
            let data = ["userlist": users]
            return try req.view().render("crud", data)
        }
    }
    
    func create(_ req: Request) throws -> Future<Response> {
        return try req.content.decode(Users.self).flatMap { user in
            return user.save(on: req).map { _ in
                return req.redirect(to: "users")
            }
        }
    }
    
    func update(_ req: Request) throws -> Future<Response> {
        return try req.parameters.next(Users.self).flatMap { user in
            return try req.content.decode(UserForm.self).flatMap { userForm in
                user.name = userForm.name
                return user.save(on: req).map { _ in
                    return req.redirect(to: "/users")
                }
            }
        }
    }
    
    func delete(_ req: Request) throws -> Future<Response> {
        return try req.parameters.next(Users.self).flatMap { user in
            return user.delete(on: req).map { _ in
                return req.redirect(to: "/users")
            }
        }
    }
}

struct UserForm: Content {
    var name: String
}

