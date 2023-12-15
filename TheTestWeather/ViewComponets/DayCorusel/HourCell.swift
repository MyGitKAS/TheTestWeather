//
//  HourCell.swift
//  TheTestWeather
//
//  Created by Aleksey Kuhlenkov on 11.12.23.
//

import UIKit
import SnapKit

final class HourCell: UICollectionViewCell {
    var hourLabel = UILabel()
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
        addSubview(hourLabel)
        addSubview(weatherImage)
        addSubview(tempLabel)
        
        tempLabel.font = UIFont.systemFont(ofSize: 20)
        tempLabel.isWhite()
        hourLabel.isWhite()
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
            make.height.width.equalTo(45)
            make.top.equalTo(hourLabel.snp_bottomMargin).offset(10)
        }
        
        tempLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(weatherImage.snp_bottomMargin).offset(10)
            }
    }
}
