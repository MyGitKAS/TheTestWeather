//
//  CurrentWeatherView.swift
//  TheTestWeather
//
//  Created by Aleksey Kuhlenkov on 11.12.23.
//

import UIKit
import SnapKit

final class CurrentWeatherView: UIView {

    let localeLabel = UILabel()
    let currentTemperatureLabel = UILabel()
    let weatherLabel = UILabel()
    let maxMinTempLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabels()
        setConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func setupLabels() {
        localeLabel.text = "---------"
        localeLabel.font = UIFont.systemFont(ofSize: 35)
        localeLabel.isWhite()
        
        currentTemperatureLabel.text = "---"
        currentTemperatureLabel.font = UIFont.systemFont(ofSize: 80)
        currentTemperatureLabel.isWhite()
        
        weatherLabel.text = "-----"
        weatherLabel.font = UIFont.systemFont(ofSize: 25)
        weatherLabel.isWhite()
        
        maxMinTempLabel.text = "----  ----"
        maxMinTempLabel.isWhite()
        
        localeLabel.textAlignment = .center
        currentTemperatureLabel.textAlignment = .center
        weatherLabel.textAlignment = .center
        maxMinTempLabel.textAlignment = .center
        
        addSubview(localeLabel)
        addSubview(currentTemperatureLabel)
        addSubview(weatherLabel)
        addSubview(maxMinTempLabel)
    }
}

extension CurrentWeatherView: ViewComponentProtocol {
    func reloadData(data: Weather? ) {
        let localeLanguage = Helper.getLanguage()
        guard let data = data else { return }
        localeLabel.text = data.location.name
        weatherLabel.text = data.current.condition.text
        let maxText = NSLocalizedString("max_label", comment: "")
        let minText = NSLocalizedString("min_label", comment: "")
        if localeLanguage == "ru" {
            currentTemperatureLabel.text = "\(data.current.tempC.toInt())°C"
            let day = data.forecast.forecastday[0].day
            maxMinTempLabel.text = "\(maxText).: \(day.maxtempC.toInt())° | \(minText).: \(day.mintempC.toInt())°"
        } else {
            currentTemperatureLabel.text = "\(data.current.tempF.toInt())°F"
            let day = data.forecast.forecastday[0].day
            maxMinTempLabel.text = "\(maxText).: \(day.maxtempF.toInt())° | \(minText).: \(day.mintempF.toInt())°"
        }
    }
}

extension CurrentWeatherView {
    
    private func setConstraints() {
        self.snp.makeConstraints { make in
            make.height.width.equalTo(180)
            }
        
        localeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.snp_topMargin).offset(5)
            }
                
        currentTemperatureLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(localeLabel.snp_bottomMargin).offset(1)
            }

        weatherLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(currentTemperatureLabel.snp_bottomMargin).offset(5)
            }

        maxMinTempLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(weatherLabel.snp_bottomMargin).offset(10)
            }
    }
}
