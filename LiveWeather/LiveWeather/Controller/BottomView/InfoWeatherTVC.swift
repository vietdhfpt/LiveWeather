//
//  InfoWeatherTVC.swift
//  LiveWeather
//
//  Created by Do Hoang Viet on 8/2/18.
//  Copyright © 2018 Do Hoang Viet. All rights reserved.
//

import UIKit

protocol InfoWeatherTVCDelegate: class {
    func didSelectedIndex(index: Int?)
}

class MulticastDelegate<T> {
    private var delegates = [Weak]()
    
    func add(_ delegate: T) {
        delegates.append(Weak(value: delegate as AnyObject))
    }
    
    func remove(_ delegate: T) {
        let weak = Weak(value: delegate as AnyObject)
        if let index = delegates.index(of: weak) {
            delegates.remove(at: index)
        }
    }
    
    func invoke(_ invocation: @escaping (T) -> ()) {
        delegates = delegates.filter({$0.value != nil})
        delegates.forEach({
            if let delegate = $0.value as? T {
                invocation(delegate)
            }
        })
    }
}

class Weak: Equatable {
    weak var value: AnyObject?
    
    init(value: AnyObject) {
        self.value = value
    }
    
    static func ==(lhs: Weak, rhs: Weak) -> Bool {
        return lhs.value === rhs.value
    }
}

class InfoWeatherTVC: UITableViewController {
    
    var delegates = MulticastDelegate<InfoWeatherTVCDelegate>()
    
    // Get data live weather.
    var liveWeather: LiveWeather? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    // Main view controller.
    var mainViewController: ViewController?
    
    var didSelectedIndex: Int? {
        didSet {
            delegates.invoke { [weak self] delegate in
                if let didSelectedIndex = self?.didSelectedIndex {
                    delegate.didSelectedIndex(index: didSelectedIndex)
                }
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
    
    deinit {
        print("Dead")
    }
}

// MARK: - Table view data source.
extension InfoWeatherTVC {
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
            if let imageTypeWeather = TypeOfWeather.init(rawValue: weathers.infoWeathers[0].main) {
                cell.imgTypeWeather.image = UIImage(named: imageTypeWeather.imageString)
            }
            
            if let temp = weathers.temp {
                cell.minTempLabel.text = temp.min.toCelsius.textDisplay1
                cell.maxTempLabel.text = temp.max.toCelsius.textDisplay1
            }
        }
        return cell
    }
}

// MARK: - Table view delegate.

extension InfoWeatherTVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.didSelectedIndex = indexPath.row
    }
}
