//
//  Manager.swift
//  LiveWeather
//
//  Created by Do Hoang Viet on 7/23/18.
//  Copyright © 2018 Do Hoang Viet. All rights reserved.
//

import Foundation

/// Comletion Handler Type
typealias CompletionHandler = (Any?, Error?) -> Void

class Manager {
    
    static let shared = Manager()
    
    func parseJSON(lat: Double, lon: Double, completionHandler: @escaping CompletionHandler) {
        let weatherUrl = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(lat)&lon=\(lon)&cnt=10&mode=json&appid=c80a2e47667cedab4873abb8a9fff762"
        
        guard let url = URL(string: weatherUrl) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                guard let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return }
                let liveWeather = LiveWeather(json: jsonData)
                completionHandler(liveWeather, nil)
            } catch let error {
                completionHandler(nil, error)
            }
        }.resume()
    }
    
}
