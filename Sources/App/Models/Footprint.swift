//
//  File.swift
//  
//
//  Created by JEAN SEBASTIEN BRUNET on 9/2/22.
//

import Fluent
import Vapor

final class Footprint: Model, Content {
    
    static let schema = "footprints"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "user_id")
    var user: User
    
    @Field(key: "actualFootprint")
    var actualFootprint: Double
    
    @Field(key: "carMake")
    var carMake: String
    
    @Field(key: "carModel")
    var carModel: String
    
    @Field(key: "date")
    var date: String
    
    @Field(key: "startingAdressLat")
    var startingAdressLat: Double
    
    @Field(key: "startingAdressLon")
    var startingAdressLon: Double
    
    @Field(key: "destAdressLat")
    var destAdressLat: Double
    
    @Field(key: "destAdressLon")
    var destAdressLon: Double
    
    @Field(key: "startingAdress")
    var startingAdress: String
    
    @Field(key: "destinationAdress")
    var destinationAdress: String
    
    @Field(key: "distance")
    var distance: Double
    
    @Field(key: "numberOfPax")
    var numberOfPax: Int
    
    @Field(key: "numberOfSeats")
    var numberOfSeats: Int
    
    @Field(key: "occupancyScore")
    var occupancyScore: Int
    
    @Field(key: "unoccupiedSeats")
    var unoccupiedSeats: Int
    
    @Field(key: "wastedCo2")
    var wastedCo2: Double
    
    init () { }
    
    init(id: UUID? = nil, actualFootprint: Double, carMake: String, carModel: String, date: String, startingAdressLat: Double, startingAdressLon: Double,
         destAdressLat: Double, destAdressLon: Double, startingAdress: String, destinationAdress: String, distance: Double, numberOfPax: Int,
         numberOfSeats: Int, occupancyScore: Int, unoccupiedSeats: Int, wastedCo2: Double, userID: User.IDValue) {
        self.id = id
        self.actualFootprint = actualFootprint
        self.carMake = carMake
        self.carModel = carModel
        self.date = date
        self.startingAdressLat = startingAdressLat
        self.startingAdressLon = startingAdressLon
        self.destAdressLat = destAdressLat
        self.destAdressLon = destAdressLon
        self.startingAdress = startingAdress
        self.destinationAdress = destinationAdress
        self.distance = distance
        self.numberOfPax = numberOfPax
        self.numberOfSeats = numberOfSeats
        self.occupancyScore = occupancyScore
        self.unoccupiedSeats = unoccupiedSeats
        self.wastedCo2 = wastedCo2
        self.$user.id = userID
    }

}
