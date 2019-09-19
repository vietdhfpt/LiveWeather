//
//  ViewController.swift
//  LiveWeather
//
//  Created by Do Hoang Viet on 7/23/18.
//  Copyright © 2018 Do Hoang Viet. All rights reserved.
//

import UIKit

// MARK: - Segue Identifier.

struct SegueIdentifier {
    static let embedInfoWeather = "embedInfoWeather"
    static let embedTempWeather = "embedTempWeather"
}

class ViewController: UIViewController {

    // MARK: - Outlets.
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var typeWeatherLabel: UILabel!
    @IBOutlet weak var imageTypeWeather: UIImageView!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var bottomContainer: UIView!
    
    // Gets data live weather
    var liveWeather: LiveWeather? {
        didSet {
            self.setupData(index: 0)
            self.infoWeatherTVC.liveWeather = self.liveWeather
            self.tempWeatherCollectionVC.liveWeather = self.liveWeather
        }
    }
 
    private var infoWeatherTVC: InfoWeatherTVC = {
        let vc = InfoWeatherTVC()
        return vc
    }()
    
    private var tempWeatherCollectionVC: TemperatureWeatherVC = {
        let vc = TemperatureWeatherVC()
        return vc
    }()
    
    // MARK: - Life Cycles.
    override func viewDidLoad() {
        super.viewDidLoad()
        self.removeData()
        self.getWeatherData()
        NotificationCenter.default.addObserver(self, selector: #selector(getIndex(_:)), name: .selectedIndex, object: nil)
    }

    deinit {
        print("Remove NotificationCenter Deinit")
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Interface.
    
    /// Setup data
    ///
    /// - Parameter index: Index of weathers
    func setupData(index: Int) {
        guard let liveWeather = self.liveWeather,
            let city = liveWeather.city,
            index < liveWeather.weathers.count else {
                return
        }
        
        self.titleLabel.text = city.name
        
        let weather = liveWeather.weathers[index]
        guard let temp = weather.temp else {
            return
        }
        self.tempLabel.text = temp.day.toCelsius.textDisplay2
        self.timeLabel.text = weather.date.convertTimeIntervalToDate
        
        guard let infoWeather = weather.infoWeathers.first else {
            return
        }
        
        self.typeWeatherLabel.text = infoWeather.main
        if let imageTypeWeather = TypeOfWeather.init(rawValue: infoWeather.main) {
            self.imageTypeWeather.image = UIImage(named: imageTypeWeather.imageString)
        }
        
        self.minTempLabel.text = temp.min.toCelsius.textDisplay1
        self.maxTempLabel.text = temp.max.toCelsius.textDisplay1
    }
    
    // Remove UX.
    func removeData() {
        self.titleLabel.text = ""
        self.tempLabel.text = ""
        self.timeLabel.text = ""
        self.typeWeatherLabel.text = ""
        self.imageTypeWeather.image = nil
        self.minTempLabel.text = ""
        self.maxTempLabel.text = ""
    }
    
    // MARK: - Gets data.
    
    // Get live weather
    func getWeatherData() {
        LiveWeatherService.getWeather { (liveWeather, error) in
            guard let liveWeather = liveWeather else { return }
            self.liveWeather = liveWeather
        }
    }
    
    /// Get index
    ///
    /// - Parameter notification: Handle notification
    @objc func getIndex(_ notification: Notification) {
        if let index = notification.userInfo?["index"] as? Int {
           self.setupData(index: index)
        }
    }
    
    // MARK: - Passed data.
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier ?? "" {
        case SegueIdentifier.embedInfoWeather:
            guard let infoWeather = segue.destination as? InfoWeatherTVC else {
                return
            }
            self.infoWeatherTVC = infoWeather
        case SegueIdentifier.embedTempWeather:
            guard let tempWeatherCollectionVC = segue.destination as? TemperatureWeatherVC else {
                return
            }
            self.tempWeatherCollectionVC = tempWeatherCollectionVC
        default:
            return
        }
    }
}
