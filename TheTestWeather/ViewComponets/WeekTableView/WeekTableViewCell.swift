//
//  WeekTableViewCell.swift
//  TheTestWeather
//
//  Created by Aleksey Kuhlenkov on 12.12.23.
//

import UIKit
import SnapKit

final class WeekTableViewCell: UITableViewCell {
    
    var dayLabel = UILabel()
    var tempMaxLabel = UILabel()
    var tempMinLabel = UILabel()
    var weatherImageView = UIImageView()
    let scaleView = WeatherScaleView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupLabels()
        setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupView() {
        backgroundColor = .clear
    }
    
    private func setupLabels() {
        addSubview(dayLabel)
        addSubview(tempMaxLabel)
        addSubview(tempMinLabel)
        addSubview(weatherImageView)
        addSubview(scaleView)
        
        tempMaxLabel.isWhite()
        tempMinLabel.isWhite()
        dayLabel.isWhite()
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
                make.height.width.equalTo(40)
                make.trailing.equalTo(scaleView.snp.leading).offset(-60)
            }
        
            tempMinLabel.snp.makeConstraints { make in
                make.centerY.equalTo(self)
                make.trailing.equalTo(scaleView.snp.leading).offset(-15)
            }
        
            scaleView.snp.makeConstraints { make in
                make.centerY.equalTo(self)
                make.trailing.equalTo(self.snp.trailing).offset(-65)
                make.width.equalTo(80)
                make.height.equalTo(scaleView.frame.width)
            }
        
            tempMaxLabel.snp.makeConstraints { make in
                make.centerY.equalTo(self)
                make.trailing.equalTo(self).offset(-20)
            }
    }
}
