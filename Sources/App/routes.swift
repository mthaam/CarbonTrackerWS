import Fluent
import Vapor

func routes(_ app: Application) throws {
    
    // MARK: CONTROLLERS
    let footprintController = FootprintController()
    let userController = UserController()

    // MARK: GROUPS
    
    let basicGroup = app.grouped(User.authenticator()).grouped(User.guardMiddleware())
    let tokenGroup = app.grouped(UserToken.authenticator()).grouped(UserToken.guardMiddleware())
    
    // MARK: - FOOTPRINT REQUESTS
    
    tokenGroup.get("footprints", use: footprintController.index)
    tokenGroup.post("footprints", use: footprintController.create)
    tokenGroup.delete("footprints", ":footprintID", use: footprintController.delete)
    tokenGroup.get("footprintsCount", use: footprintController.count)
    
    // MARK: - USER REQUESTS
    app.post("users", use: userController.create)
    basicGroup.post("login", use: userController.login)

    try app.register(collection: TodoController())
}
