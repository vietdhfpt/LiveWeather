//
//  LiveWeather.swift
//  LiveWeather
//
//  Created by Do Hoang Viet on 7/23/18.
//  Copyright © 2018 Do Hoang Viet. All rights reserved.
//

import Foundation

typealias JSON = Dictionary<AnyHashable, Any>

// MARK: - LiveWeather.
struct LiveWeather {
    let city: City?
    var weathers: [Weather] = []
    
    init?(json: JSON) {
        guard let city = json["city"] as? JSON,
            let weathers = json["list"] as? [JSON] else {
            return nil
        }
        self.city = City(json: city)
        for weather in weathers {
            if let weather = Weather(json: weather) {
                self.weathers.append(weather)
            }
        }
    }
}

// MARK: - City.
struct City {
    let id: Int
    let name: String
    let coordinate: Coordinate?
    
    init?(json: JSON) {
        guard let id = json["id"] as? Int,
                let name = json["name"] as? String,
        let coordinate = json["coord"] as? JSON else {
                return nil
        }
        self.id = id
        self.name = name
        self.coordinate = Coordinate(json: coordinate)
    }
}

// MARK: - Coordinate.
struct Coordinate {
    let lon: Double
    let lat: Double
    
    init?(json: JSON) {
        guard let lon = json["lon"] as? Double,
            let lat = json["lat"] as? Double else {
                return nil
        }
        self.lon = lon
        self.lat = lat
    }
}

// MARK: - Weather.
struct Weather {
    let date: Double
    let temp: Temp?
    var infoWeathers: [InfoWeather] = []

    init?(json: JSON) {
        guard let date = json["dt"] as? Double,
                let temp = json["temp"] as? JSON,
            let infoWeathers = json["weather"] as? [JSON] else {
                return nil
        }
        self.date = date
        self.temp = Temp(json: temp)
        for infoWeather in infoWeathers {
            if let infoWeather = InfoWeather(json: infoWeather) {
                self.infoWeathers.append(infoWeather)
            }
        }
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
        guard let day = json["day"] as? Double,
                let min = json["min"] as? Double,
                let max = json["max"] as? Double,
                let night = json["night"] as? Double,
                let eve = json["eve"] as? Double,
                let morn = json["morn"] as? Double else {
                return nil
        }
        self.day = day
        self.min = min
        self.max = max
        self.night = night
        self.eve = eve
        self.morn = morn
    }
}

// MARK: - InfoWeather.
struct InfoWeather {
    let main: String
    let description: String
    let icon: String
    
    init?(json: JSON) {
        guard let main = json["main"] as? String,
                let description = json["description"] as? String,
            let icon = json["icon"] as? String else {
                return nil
        }
        self.main = main
        self.description = description
        self.icon = icon
    }
}
