//
//  LiveWeather.swift
//  LiveWeather
//
//  Created by Do Hoang Viet on 7/23/18.
//  Copyright © 2018 Do Hoang Viet. All rights reserved.
//

import Foundation
import SwiftyJSON

// MARK: - LiveWeather.
struct LiveWeather {
    let city: City?
    var weathers: [Weather] = []
    
    init?(json: JSON) {
        self.city = City(json: json["city"])
        let weathers = json["list"].arrayValue.map({ Weather(json: $0) })
        self.weathers = weathers
    }
}

// MARK: - City.
struct City {
    let id: Int
    let name: String
    let coordinate: Coordinate?
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.coordinate = Coordinate(json: json["coord"])
    }
}

// MARK: - Coordinate.
struct Coordinate {
    let lon: Double
    let lat: Double
    
    init(json: JSON) {
        self.lon = json["lon"].doubleValue
        self.lat = json["lat"].doubleValue
    }
}

// MARK: - Weather.
struct Weather {
    let date: Double
    let temp: Temp?
    var infoWeathers: [InfoWeather] = []

    init(json: JSON) {
        self.date = json["dt"].doubleValue
        self.temp = Temp(json: json["temp"])
        let infoWeathers = json["weather"].arrayValue.map({ InfoWeather(json: $0) })
        self.infoWeathers = infoWeathers
    }
}

// MARK: - Temperature.
struct Temp {
    let day: Double
    let min: Double
    let max: Double
    let night: Double
    let eve: Double
    let morn: Double
    
    init?(json: JSON) {
        self.day = json["day"].doubleValue
        self.min = json["min"].doubleValue
        self.max = json["max"].doubleValue
        self.night = json["night"].doubleValue
        self.eve = json["eve"].doubleValue
        self.morn = json["morn"].doubleValue
    }
}

// MARK: - InfoWeather.
struct InfoWeather {
    let main: String
    let description: String
    let icon: String
    
    init(json: JSON) {
        self.main = json["main"].stringValue
        self.description = json["description"].stringValue
        self.icon = json["icon"].stringValue
    }
}
