//
//  Extension+Enum.swift
//  LiveWeather
//
//  Created by Do Hoang Viet on 8/4/18.
//  Copyright © 2018 Do Hoang Viet. All rights reserved.
//

import UIKit


// MARK: - Enum Type Weather.

enum TypeOfWeather: String {
    case rain = "Rain"
    case sunny = "Sunny"
    case clear = "Clear"
    case clouds = "Clouds"
    
    var imageString: String {
        switch self {
        case .rain:
            return "icons8-torrential_rain"
        case .sunny:
            return "icons8-sun"
        case .clear:
            return "icons8-partly_cloudy_day_filled"
        case .clouds:
            return "icons8-clouds_filled"
        }
    }
}

// MARK: - Enum Type of Day.

enum TypeOfDay: String {
    case day = "day"
    case night = "night"
    case eve = "eve"
    case morn = "morn"
    
    var imageString: String {
        switch self {
        case .day:
            return "icons8-sun_filled"
        case .night:
            return "icons8-partly_cloudy_night_filled"
        case .eve:
            return "icons8-sunset_filled"
        case .morn:
            return "icons8-sunrise_filled"
        }
    }
}
