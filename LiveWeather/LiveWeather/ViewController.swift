//
//  ViewController.swift
//  LiveWeather
//
//  Created by Do Hoang Viet on 7/23/18.
//  Copyright © 2018 Do Hoang Viet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let lat: Double = 21.013493
    let lon: Double = 105.796525
    
    var liveWeather: LiveWeather?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Manager.shared.parseJSON(lat: lat, lon: lon) { (data, error) in
            guard let liveWeather = data as? LiveWeather else { return }
            self.liveWeather = liveWeather
        }
    }
}

