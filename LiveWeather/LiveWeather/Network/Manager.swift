//
//  Manager.swift
//  LiveWeather
//
//  Created by Do Hoang Viet on 7/23/18.
//  Copyright © 2018 Do Hoang Viet. All rights reserved.
//

import Foundation
import SwiftyJSON
import Moya

enum API {
    case getWeather
}

extension API: TargetType {
    static let baseUrl = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=51.503311&lon=0.127740&cnt=10&mode=json&appid=c80a2e47667cedab4873abb8a9fff762"
    
    var baseURL: URL {
        return URL(string: API.baseUrl)!
    }
    
    var path: String {
        return ""
    }
    
    var method: Moya.Method {
        switch self {
        case .getWeather:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getWeather:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}
