//
//  File.swift
//  
//
//  Created by JEAN SEBASTIEN BRUNET on 10/2/22.
//

import Foundation
import FluentKit
import Fluent
import Vapor

final class User: Model, Content {
    static let schema = "users"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "firstName")
    var firstName: String
    
    @Field(key: "email")
    var email: String
    
    @Field(key: "password_hash")
    var passwordHash: String
    
    @Children(for: \UserToken.$user)
    var tokens: [UserToken]
    
    @Children(for: \Footprint.$user)
    var footprints: [Footprint]
    
    init() { }
    
    init(id: UUID? = nil, name: String, firstName: String, email: String, passwordHash: String) {
        self.id = id
        self.name = name
        self.firstName = firstName
        self.email = email
        self.passwordHash = passwordHash
    }
}

extension User: ModelAuthenticatable {

    static var usernameKey = \User.$email
    
    static var passwordHashKey = \User.$passwordHash
    
    func verify(password: String) throws -> Bool {
        return try Bcrypt.verify(password, created: self.passwordHash)
    }
    
    func generateToken() throws -> UserToken {
        return try UserToken(value: [UInt8].random(count: 16).base64, userID: self.requireID())
    }
    
}

extension User {
    
    func generateFootprint(from decodedFootprint: FootprintDataObject) throws -> Footprint {
        return try Footprint(actualFootprint: decodedFootprint.actualFootprint, carMake: decodedFootprint.carMake, carModel: decodedFootprint.carModel, date: decodedFootprint.date, startingAdressLat: decodedFootprint.startingAdressLat, startingAdressLon: decodedFootprint.startingAdressLon, destAdressLat: decodedFootprint.destAdressLat, destAdressLon: decodedFootprint.destAdressLon, startingAdress: decodedFootprint.startingAdress, destinationAdress: decodedFootprint.destinationAdress, distance: decodedFootprint.distance, numberOfPax: decodedFootprint.numberOfPax, numberOfSeats: decodedFootprint.numberOfSeats, occupancyScore: decodedFootprint.occupancyScore, unoccupiedSeats: decodedFootprint.unoccupiedSeats, wastedCo2: decodedFootprint.wastedCo2, userID: self.requireID())
    }
}
