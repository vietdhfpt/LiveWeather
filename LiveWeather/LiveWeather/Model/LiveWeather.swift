//
//  LiveWeather.swift
//  LiveWeather
//
//  Created by Do Hoang Viet on 7/23/18.
//  Copyright © 2018 Do Hoang Viet. All rights reserved.
//

import Foundation

struct LiveWeather: Codable {
    let city: City
    let weather: [Weather]
    
    private enum CodingKeys: String, CodingKeys {
        case weather = "list"
        case city
    }
}

struct City: Codable {
    let id: Int
    let name: String
    let coordinate: Coordinate
    struct Coordinate: Codable {
        let lat: Float
        let lon: Float
    }
    
    private enum CodingKeys: String, CodingKeys {
        case id, name
        case coordinate = "coord"
    }
}

struct Weather: Codable {
    let date: Int
    let temp: Temp
    let infoWeather: [InfoWeather]
    
    private enum CodingKeys: String, CodingKeys {
        case date = "dt"
        case infoWeather = "weather"
        case temp
    }
}

struct Temp: Codable {
    let day: Int
    let min: Int
    let max: Int
    let night: Int
    let eve: Int
    let morn: Int
}

struct InfoWeather: Codable {
    let main: String
    let description: String
    let icon: String
}
