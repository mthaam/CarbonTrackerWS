import Fluent
import FluentMySQLDriver
import FluentSQLiteDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    // test supervisor:
    // app.http.server.configuration.hostname = ""
    // app.http.server.configuration.port = 8080

    if app.environment == .production {
        var tlsCustomConfiguration = TLSConfiguration.makeClientConfiguration()
        tlsCustomConfiguration.certificateVerification = .none
        app.databases.use(.mysql(hostname: "127.0.0.1", username: "vapor_user", password: "", tlsConfiguration: tlsCustomConfiguration), as: .mysql)
    } else {
        app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)
    }

    app.migrations.add(CreateUser())
    app.migrations.add(CreateUserToken())
    app.migrations.add(CreateFootprint())

    // register routes
    try routes(app)
}
