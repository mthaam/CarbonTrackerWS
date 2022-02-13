//
//  File.swift
//  
//
//  Created by SEBASTIEN BRUNET on 09/02/2022.
//

import Foundation
import Fluent
import Vapor

struct FootprintController {
    
    func index(req: Request) throws -> EventLoopFuture<[Footprint]> {
        // fetch user + auth
        let user = try req.auth.require(User.self)
        // returning all footprints for given user
        return Footprint.query(on: req.db)
            .filter(\.$user.$id, .equal, try user.requireID())
            .all()
    }
    
    func count(req: Request) throws -> EventLoopFuture<Int> {
        try req.auth.require(User.self)
        return Footprint.query(on: req.db).all()
            .map { footprintList -> Int in
                return footprintList.count
            }
    }
    
    func create(req: Request) throws -> EventLoopFuture<Footprint> {
        // fetch user + auth
        let user = try req.auth.require(User.self)
        // fetching request's footprint + decoding
        let footprint = try req.content.decode(FootprintDataObject.self)
        // generating a new footprint from User class
        let userFootprint = try user.generateFootprint(from: footprint)
        // Returning save
        return userFootprint.save(on: req.db).transform(to: userFootprint)
    }
    
    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        try req.auth.require(User.self)
        return Footprint.find(req.parameters.get("footprintID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
    
}
