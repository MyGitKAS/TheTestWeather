//
//  HourCell.swift
//  TheTestWeather
//
//  Created by Aleksey Kuhlenkov on 11.12.23.
//

import UIKit
import SnapKit

class HourCell: UICollectionViewCell {
    var hourLabel = UILabel()
    //var weatherImage = UILabel()
    var weatherImage = UIImageView()
    var tempLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabels()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLabels() {
      
        hourLabel.text = " 22"
        addSubview(hourLabel)
       
        //weatherImage.text = " ☁️"
        addSubview(weatherImage)
        
        tempLabel.text = "-8°"
        tempLabel.font = UIFont.systemFont(ofSize: 20)
        addSubview(tempLabel)
    }
}

extension HourCell {
    private func setConstraints() {
        hourLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(self.snp.top)
            }
              
        weatherImage.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.height.width.equalTo(50)
            make.top.equalTo(hourLabel.snp_bottomMargin).offset(10)
        }
        
        tempLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(weatherImage.snp_bottomMargin).offset(10)
            }
    }
}
