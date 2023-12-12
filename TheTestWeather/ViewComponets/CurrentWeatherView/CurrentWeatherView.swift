//
//  CurrentWeatherView.swift
//  TheTestWeather
//
//  Created by Aleksey Kuhlenkov on 11.12.23.
//

import UIKit
import SnapKit

class CurrentWeatherView: UIView {

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
        localeLabel.text = "Minsk"
        localeLabel.font = UIFont.systemFont(ofSize: 30)
        
        currentTemperatureLabel.text = "-8°C"
        currentTemperatureLabel.font = UIFont.systemFont(ofSize: 50)
        
        weatherLabel.text = "Wind§"
        weatherLabel.font = UIFont.systemFont(ofSize: 25)
        maxMinTempLabel.text = "max: -3°C :: min: -10°C"
        
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
    func setData(data: Weather) {
        //
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
            make.top.equalTo(currentTemperatureLabel.snp_bottomMargin).offset(10)
            }

        maxMinTempLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(weatherLabel.snp_bottomMargin).offset(20)
            }
    }
}
