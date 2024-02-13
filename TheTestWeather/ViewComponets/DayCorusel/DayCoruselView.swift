//
//  dayCoruselView.swift
//  TheTestWeather
//
//  Created by Aleksey Kuhlenkov on 11.12.23.
//

import UIKit

final class DayCoruselView: UIView {
  
    private var collectionView: UICollectionView!
    private var weather: Weather?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HourCell.self, forCellWithReuseIdentifier: "HourCell")
        collectionView.backgroundColor = #colorLiteral(red: 0.1938996013, green: 0.3328887908, blue: 0.3157452245, alpha: 0.1990463361)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = true
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.layer.cornerRadius = 20
        addSubview(collectionView)
    }
}

extension DayCoruselView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: 50, height: 90)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }
}

extension DayCoruselView: UICollectionViewDelegate {}

extension DayCoruselView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourCell", for: indexPath) as! HourCell
        
        guard let days = weather?.forecast.forecastday else { return cell }
        let locale = Helper.getLanguage()
        let currentHour = Helper.getCurrentHour()
        
        let dayNumber = (currentHour + indexPath.row) / 24
        let hourNumber = (currentHour + indexPath.row) % 24
        
        var hourNumberString = String(hourNumber)
        let dataHour = days[dayNumber].hour[hourNumber]
        let iconURL = days[dayNumber].hour[hourNumber].condition.icon
        let iconImage2 = Helper.stringToImage(str: iconURL) ?? UIImage(named: "naicon")
        
        let temperature = locale == "ru" ? dataHour.tempC : dataHour.tempF
        
        if indexPath.row == 0 {
            hourNumberString = NSLocalizedString("now_label", comment: "")
        }
            
        cell.hourLabel.text = hourNumberString
        cell.tempLabel.text = String(temperature.toInt()) + "°"
        cell.weatherImage.image = iconImage2
        return cell
    }
}

extension DayCoruselView: ViewComponentProtocol {
    func reloadData(data: Weather?) {
        self.weather = data
        collectionView.reloadData()
    }
}


