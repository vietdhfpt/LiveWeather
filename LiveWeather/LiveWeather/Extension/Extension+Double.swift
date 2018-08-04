//
//  Extension+Double.swift
//  LiveWeather
//
//  Created by Do Hoang Viet on 8/2/18.
//  Copyright © 2018 Do Hoang Viet. All rights reserved.
//

import Foundation

extension Double {
    // Convert from celsius to kelvin.
    var toKalvin: Double {
        return self + 273.15
    }
    
    // Convert from kelvin to celsius.
    var toCelsius: Double {
        return self - 273.15
    }
    
    // Convert time interval to date
    var convertTimeIntervalToDate: String? {
        let date = Date(timeIntervalSince1970: self)
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "EEEE, MMM d"
        
        return dayTimePeriodFormatter.string(from: date)
    }
    
    // Convert time interval to day
    var convertTimeIntervalToDay: String? {
        let date = Date(timeIntervalSince1970: self)
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "EEEE"
        
        return dayTimePeriodFormatter.string(from: date)
    }
}
