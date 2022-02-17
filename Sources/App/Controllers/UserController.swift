//
//  File.swift
//  
//
//  Created by JEAN SEBASTIEN BRUNET on 10/2/22.
//

import Foundation
import Vapor
import Fluent

struct UserController {
    
    func create(req: Request) throws -> EventLoopFuture<User> {
        try User.Create.validate(content: req)
        let receivedData = try req.content.decode(User.Create.self)
        let user = try User(name: receivedData.name,
                            firstName: receivedData.firstName,
                            email: receivedData.email,
                            passwordHash: Bcrypt.hash(receivedData.password))
        return user.save(on: req.db).transform(to: user)
    }
    
    func login(req: Request) throws -> EventLoopFuture<UserToken> {
        let user = try req.auth.require(User.self)
        let token = try user.generateToken()
        return token.save(on: req.db).transform(to: token)
    }
    
}

extension User {

    struct Create: Content, Validatable {
        
        static func validations(_ validations: inout Validations) {
            validations.add("email", as: String.self, is: .email, required: true)
            validations.add("name", as: String.self, is: .count(1...), required: true)
            validations.add("firstName", as: String.self, is: .count(2...), required: true)
            validations.add("password", as: String.self, is: .count(8...), required: true)
        }
        
        var name: String
        var firstName: String
        var email: String
        var password: String
    }
}

