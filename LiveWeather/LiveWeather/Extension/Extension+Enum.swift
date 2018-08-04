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
            return ""
        case .clouds:
            return ""
        }
    }
}

// MARK: - Enum Type of Day.

enum TypeOfDay: String {
    case day, night, eve, morn
}
