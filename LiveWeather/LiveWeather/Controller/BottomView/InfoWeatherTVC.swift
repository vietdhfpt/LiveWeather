//
//  InfoWeatherTVC.swift
//  LiveWeather
//
//  Created by Do Hoang Viet on 8/2/18.
//  Copyright © 2018 Do Hoang Viet. All rights reserved.
//

import UIKit

class InfoWeatherTVC: UITableViewController {
    
    var liveWeather: LiveWeather? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Life cycles.
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source.

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let liveWeather = self.liveWeather else {
            return 0
        }
        return liveWeather.weathers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoWeatherTableViewCell", for: indexPath)
        if let cell = cell as? InfoWeatherTableViewCell {
            guard let liveWeather = self.liveWeather else {
                return cell
            }
            guard indexPath.row < liveWeather.weathers.count else { return cell }
            let weathers = liveWeather.weathers[indexPath.row]
            cell.titleLabel.text = weathers.date.convertTimeIntervalToDay
            
            guard !weathers.infoWeathers.isEmpty else {
                return cell
            }
            if let imageTypeWeather = TypeWeather.init(rawValue: weathers.infoWeathers[0].main) {
                cell.imgTypeWeather.image = UIImage(named: imageTypeWeather.imageString)
            }
            
            if let temp = weathers.temp {
                cell.minTempLabel.text = String.init(format: "↑ " + "%0.f" + "°", temp.min.toCelsius)
                cell.maxTempLabel.text = String.init(format: "↓ " + "%0.f" + "°", temp.max.toCelsius)
            }
        }
        return cell
    }
}
