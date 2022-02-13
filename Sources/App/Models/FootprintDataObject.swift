//
//  File.swift
//  
//
//  Created by SEBASTIEN BRUNET on 09/02/2022.
//

import Foundation
import Fluent
import Vapor

struct FootprintDataObject : Content {
    let actualFootprint: Double
    let carMake: String
    let carModel: String
    let date: String
    let startingAdressLat: Double
    let startingAdressLon: Double
    let destAdressLat: Double
    let destAdressLon: Double
    let startingAdress: String
    let destinationAdress: String
    let distance: Double
    let numberOfPax: Int
    let numberOfSeats: Int
    let occupancyScore: Int
    let unoccupiedSeats: Int
    let wastedCo2: Double
}
