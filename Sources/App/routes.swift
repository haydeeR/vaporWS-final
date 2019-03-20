import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    
    router.get("hello") { req in
        return "Hello, World"
    }
    
    router.get("age") { req in
        return 32
    }
    
    router.get("json") { req in
        return Person(name: "Haydee", age: 19)
    }
    
    let userController = UserController()
    router.get("users", use: userController.list)
    router.post("users", use: userController.create)
    router.post("users", Users.parameter, "update", use: userController.update)
    router.post("users", Users.parameter, "delete", use: userController.delete)

    struct Person: Content {
        var name: String
        var age: Int
    }
}

