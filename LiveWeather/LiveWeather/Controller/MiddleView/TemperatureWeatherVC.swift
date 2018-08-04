//
//  TemperatureWeatherVC.swift
//  LiveWeather
//
//  Created by Do Hoang Viet on 8/4/18.
//  Copyright © 2018 Do Hoang Viet. All rights reserved.
//

import UIKit

class TemperatureWeatherVC: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var morningLabel: UILabel!
    @IBOutlet weak var eveningLabel: UILabel!
    @IBOutlet weak var nightLabel: UILabel!
    
    // Gets data live weather
    var liveWeather: LiveWeather? {
        didSet {
            DispatchQueue.main.sync {
                self.removeData()
                self.setupData(index: 0)
            }
        }
    }
    
    // MARK: - Life cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(getIndex(_:)), name: .selectedIndex, object: nil)
    }
    
    deinit {
        print("Remove NotificationCenter Deinit")
        NotificationCenter.default.removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Data
    
    /// Setup data
    ///
    /// - Parameter index: Index of weathers
    func setupData(index: Int) {
        guard let liveWeather = self.liveWeather else {
            return
        }
        
        guard index < liveWeather.weathers.count else {
            return
        }
        
        let weather = liveWeather.weathers[index]
        if let temp = weather.temp {
            self.dayLabel.text = temp.min.toCelsius.textDisplay2
            self.morningLabel.text = temp.morn.toCelsius.textDisplay2
            self.eveningLabel.text = temp.eve.toCelsius.textDisplay2
            self.nightLabel.text = temp.night.toCelsius.textDisplay2
        }
    }
    
    // Remove data
    func removeData() {
        self.dayLabel.text = ""
        self.morningLabel.text = ""
        self.eveningLabel.text = ""
        self.nightLabel.text = ""
    }
    
    /// Get index
    ///
    /// - Parameter notification: Handle notification
    @objc func getIndex(_ notification: Notification) {
        if let index = notification.userInfo?["index"] as? Int {
            self.setupData(index: index)
        }
    }
}
