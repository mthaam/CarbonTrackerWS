//
//  File.swift
//  
//
//  Created by JEAN SEBASTIEN BRUNET on 10/2/22.
//

import Foundation
import Fluent
import Vapor

struct CreateUser: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("users")
            .id()
            .field("name", .string, .required)
            .field("firstName", .string, .required)
            .field("email", .string, .required)
            .field("password_hash", .string, .required)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("users").delete()
    }

}
