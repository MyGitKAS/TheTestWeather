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
        let dataHour = weather?.forecast.forecastday.first?.hour[indexPath.row]
        var hour = dataHour?.time ?? "--"
        let iconUrl = dataHour?.condition.icon ?? ""
        let icon = Service.stringToImage(str: iconUrl) ?? UIImage(named: "naicon")
        
        if hour != "--" {
            let components = hour.components(separatedBy: " ")
            let timeComponent = components[1].components(separatedBy: ":")
            let futureTime = InfoService.calculateTime(hours: Int(timeComponent[0]) ?? 00)
            hour = String(futureTime)
        }
        
        let temperature = dataHour?.tempC ?? 0.0
        
        if indexPath.row == 0 {
            hour = "Now"
        }
        cell.hourLabel.text = hour
        cell.tempLabel.text = String(temperature.toInt()) + "°"
        cell.weatherImage.image = icon
        return cell
    }
}

extension DayCoruselView: ViewComponentProtocol {
    func reloadData(data: Weather?) {
        self.weather = data
        collectionView.reloadData()
    }
}

