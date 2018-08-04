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
}

class ViewController: UIViewController {
    
    // MARK: - Variable.
    let lat: Double = 51.503311
    let lon: Double = 0.127740
    
    var liveWeather: LiveWeather? {
        didSet {
            self.setupTopView(index: 0)
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

    // MARK: - Interface.
    
    // Setup UX.
    func setupTopView(index: Int) {
        DispatchQueue.main.async {
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
            self.tempLabel.text = String.init(format: "%0.f" + "°C", temp.day.toCelsius)
            self.timeLabel.text = weather.date.convertTimeIntervalToDate
            
            guard let infoWeather = weather.infoWeathers.first else {
                return
            }
            
            self.typeWeatherLabel.text = infoWeather.main
            if let imageTypeWeather = TypeOfWeather.init(rawValue: infoWeather.main) {
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
            self.infoWeatherTVC?.delegate = self
        default:
            return
        }
    }
}

// MARK: - Delegate.

extension ViewController: InfoWeatherTVCDelegate {
    func didSelectedIndex(index: Int) {
        self.resetUI()
        self.setupTopView(index: index)
    }
}

