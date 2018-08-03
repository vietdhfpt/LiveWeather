//
//  ViewController.swift
//  LiveWeather
//
//  Created by Do Hoang Viet on 7/23/18.
//  Copyright © 2018 Do Hoang Viet. All rights reserved.
//

import UIKit

struct SegueIdentifier {
    static let embedInfoWeather = "embedInfoWeather"
}

enum TypeWeather: String {
    case rain = "Rain"
    case sunny = "Sunny"
    
    var imageString: String {
        switch self {
        case .rain:
            return "icons8-torrential_rain"
        case .sunny:
            return "icons8-sun"
        }
    }
}

class ViewController: UIViewController {
    
    // MARK: - Variable.
    let lat: Double = 21.013493
    let lon: Double = 105.796525
    
    var liveWeather: LiveWeather? {
        didSet {
            setupUI()
            self.infoWeatherTVC?.liveWeather = self.liveWeather
        }
    }
 
    private var infoWeatherTVC: InfoWeatherTVC?
    
    // MARK: - Outlets.
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var typeWeatherLabel: UILabel!
    @IBOutlet weak var imageTypeWeather: UIImageView!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var bottomContainer: UIView!
    
    // MARK: - Life Cycles.
    override func viewDidLoad() {
        super.viewDidLoad()
        self.resetUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getWeatherData()
    }

    // MARK: - Setup.
    
    // Setup UX.
    func setupUI() {
        DispatchQueue.main.async {
            guard let liveWeather = self.liveWeather,
                let city = liveWeather.city else {
                    return
            }
            self.titleLabel.text = city.name
            
            let firstWeathers = liveWeather.weathers.first
            guard let firstWeather = firstWeathers, let temp = firstWeathers?.temp else {
                return
            }
            self.tempLabel.text = String.init(format: "%0.f" + "°C", temp.day.toCelsius)
            self.timeLabel.text = firstWeather.date.convertTimeIntervalToDate
            
            guard let firstInfoWeather = firstWeather.infoWeathers.first else {
                return
            }
            
            self.typeWeatherLabel.text = firstInfoWeather.main
            if let imageTypeWeather = TypeWeather.init(rawValue: firstInfoWeather.main) {
                self.imageTypeWeather.image = UIImage(named: imageTypeWeather.imageString)
            }
            
            self.minTempLabel.text = String.init(format: "↑ " + "%0.f" + "°", temp.min.toCelsius)
            self.maxTempLabel.text = String.init(format: "↓ " + "%0.f" + "°", temp.max.toCelsius)
        }
    }
    
    // Clear UX.
    func resetUI() {
        self.titleLabel.text = ""
        self.tempLabel.text = ""
        self.timeLabel.text = ""
        self.typeWeatherLabel.text = ""
        self.imageTypeWeather.image = nil
        self.minTempLabel.text = ""
        self.maxTempLabel.text = ""
    }
    
    // MARK: - Get data.
    
    func getWeatherData() {
        Manager.shared.parseJSON(lat: self.lat, lon: self.lon) { (data, error) in
            guard let liveWeather = data as? LiveWeather else { return }
            self.liveWeather = liveWeather
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
        default:
            return
        }
    }
}

