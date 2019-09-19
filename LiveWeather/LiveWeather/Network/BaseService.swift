//
//  BaseService.swift
//  LiveWeather
//
//  Created by Netstars.vn on 9/18/19.
//  Copyright © 2019 Do Hoang Viet. All rights reserved.
//

import Foundation
import SwiftyJSON

enum RequestError: Error {
    case unknownError
    case connectionError
    case authorizationError
    case invalidRequest
    case notFound
    case invalidResponse
    case serverError
    case serverUnavailable
}

class BaseService {
    static func requestData(api: API, completion: @escaping (JSON?, Error?) -> Void) {
        APIProvider.shared.request(api) { result in
            do {
                switch result {
                case .success(let response):
                    let jsonDict = try JSON(data: response.data)
                    completion(jsonDict, nil)
                case .failure(let error):
                    throw error
                }
            } catch {
                completion(nil, error)
            }
        }
    }
}

class LiveWeatherService: BaseService {
    static func getWeather(completion: @escaping (LiveWeather?, Error?) -> Void) {
        self.requestData(api: .getWeather, completion: { (json, error) in
            if let error = error {
                completion(nil, error)
            } else if let responseJson = json {
                guard let liveWeather = LiveWeather(json: responseJson) else { return }
                completion(liveWeather, nil)
            } else {
                completion(nil, RequestError.invalidResponse)
            }
        })
    }
}
