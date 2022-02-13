//
//  File.swift
//  
//
//  Created by JEAN SEBASTIEN BRUNET on 9/2/22.
//

import Fluent

struct CreateFootprint: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("footprints")
            .id()
            .field("user_id", .uuid, .required, .references("users", "id"))
            .field("actualFootprint", .double, .required)
            .field("carMake", .string, .required)
            .field("carModel", .string, .required)
            .field("date", .string, .required)
            .field("startingAdressLat", .double, .required)
            .field("startingAdressLon", .double, .required)
            .field("destAdressLat", .double, .required)
            .field("destAdressLon", .double, .required)
            .field("startingAdress", .string, .required)
            .field("destinationAdress", .string, .required)
            .field("distance", .double, .required)
            .field("numberOfPax", .int, .required)
            .field("numberOfSeats", .int, .required)
            .field("occupancyScore", .int, .required)
            .field("unoccupiedSeats", .int, .required)
            .field("wastedCo2", .double, .required)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("footprints").delete()
    }
}
