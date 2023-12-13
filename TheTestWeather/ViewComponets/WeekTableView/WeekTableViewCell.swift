//
//  WeekTableViewCell.swift
//  TheTestWeather
//
//  Created by Aleksey Kuhlenkov on 12.12.23.
//

import UIKit
import SnapKit

class WeekTableViewCell: UITableViewCell {
    
    var dayLabel = UILabel()
    var tempMaxLabel = UILabel()
    var tempMinLabel = UILabel()
    var weatherImageView = UIImageView()
    let progressView = UIProgressView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        progressView.trackTintColor = .green
        setupLabels()
        setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupLabels() {
        addSubview(dayLabel)
        addSubview(tempMaxLabel)
        addSubview(tempMinLabel)
        addSubview(weatherImageView)
        addSubview(progressView)
        
        dayLabel.text = "Day Week"
        weatherImageView.image = UIImage(named: "clouds")
        tempMaxLabel.text = "-5"
        tempMinLabel.text = "-9"
        
    }
    
}
   
extension WeekTableViewCell {
    private func setConstraints() {
        dayLabel.snp.makeConstraints { make in
                make.centerY.equalTo(self)
                make.leading.equalTo(self).offset(20)
            }

            weatherImageView.snp.makeConstraints { make in
                make.centerY.equalTo(self)
                make.trailing.equalTo(tempMinLabel.snp.leading).offset(-10)
            }
        
            tempMinLabel.snp.makeConstraints { make in
                make.centerY.equalTo(self)
                make.trailing.equalTo(progressView.snp.leading).offset(-15)
            }
        
            progressView.snp.makeConstraints { make in
                make.centerY.equalTo(self)
                make.trailing.equalTo(tempMaxLabel.snp.leading).offset(-15)
                make.width.equalTo(70)
    
            }
        
            tempMaxLabel.snp.makeConstraints { make in
                make.centerY.equalTo(self)
                make.trailing.equalTo(self).offset(-20)
            }
    }
}
