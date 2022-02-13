//
//  File.swift
//  
//
//  Created by JEAN SEBASTIEN BRUNET on 10/2/22.
//

import Foundation
import Vapor
import Fluent

struct CreateUserToken: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("user_tokens")
            .id()
            .field("value", .string, .required)
            .field("user_id", .uuid, .required, .references("users", "id"))
            .unique(on: "value")
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("users_tokens").delete()
    }
}
