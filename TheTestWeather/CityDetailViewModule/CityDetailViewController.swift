//
//  CityDetailViewController.swift
//  TheTestWeather
//
//  Created by Aleksey Kuhlenkov on 12.12.23.
//

import UIKit
import SnapKit

protocol CityDetailViewProtocol {
    func reloadData(weatherData: Weather)
}

class CityDetailViewController: UIViewController {
    
    let currentTemp = UILabel()
    let icon = UIImageView ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemIndigo
        setupComponents()
        setConstraints()
    }
    
    private func setupComponents() {
        view.addSubview(currentTemp)
        view.addSubview(icon)
        currentTemp.isWhite()
        currentTemp.font = UIFont.systemFont(ofSize: 60)
        currentTemp.text = "---"
        icon.image = UIImage(named: "clouds")
    }
}

extension CityDetailViewController {

    func setConstraints() {
        currentTemp.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(200)
        }

        icon.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(currentTemp.snp.bottom).offset(20)
            make.height.width.equalTo(80)
        }
    }
}

extension CityDetailViewController: CityDetailViewProtocol{
    func reloadData(weatherData: Weather) {
        let iconUrl = weatherData.forecast.forecastday[0].day.condition.icon
        let getIcon = Service.stringToImage(str: iconUrl)
        currentTemp.text = String(weatherData.current.tempC)
        self.icon.image = getIcon
      
        print(weatherData.location.name)
        print(weatherData.forecast.forecastday[0].date)
    }
}
