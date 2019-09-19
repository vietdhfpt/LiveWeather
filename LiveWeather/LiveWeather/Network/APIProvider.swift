//
//  APIProvider.swift
//  LiveWeather
//
//  Created by Netstars.vn on 9/18/19.
//  Copyright © 2019 Do Hoang Viet. All rights reserved.
//

import Foundation
import Moya

class APIProvider {
    static let shared = MoyaProvider<API>()
}
