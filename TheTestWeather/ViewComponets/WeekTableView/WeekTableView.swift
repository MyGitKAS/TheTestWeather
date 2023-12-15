//
//  WeekTableView.swift
//  TheTestWeather
//
//  Created by Aleksey Kuhlenkov on 12.12.23.
//

import UIKit
import SnapKit

final class WeekTableView: UIView {
    
    private let tableView = UITableView()
    private  let days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    private var weather: Weather?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        setupTableView()
        setConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        self.addSubview(tableView)
        tableView.layer.cornerRadius = 20
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(WeekTableViewCell.self, forCellReuseIdentifier: "WeekTableViewCell")
        tableView.isScrollEnabled = false
        tableView.allowsSelection = false
    }
    
    private func minMaxWeekTemp() -> (Double, Double) {
        guard let week = weather?.forecast.forecastday else { return (0,0)}
        var min: Double = 0
        var max: Double = 0
        
        for day in week {
            if day.day.maxtempC > max {
                max = day.day.maxtempC
            }
            if day.day.mintempC < min {
                 min = day.day.mintempC
            }
        }
        return (max,min)
    }
}

extension WeekTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count + 1
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        if let textlabel = header.textLabel {
            textlabel.font = textlabel.font.withSize(15)
            textlabel.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let numberDay = InfoService.getNumberDayWeek()
        let indexCell = indexPath.row
        var dayWeek = days[(numberDay + indexCell) % 7]
        if indexCell == 0 {
            dayWeek = "Today"
           }
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeekTableViewCell", for: indexPath) as! WeekTableViewCell
        let day = weather?.forecast.forecastday[indexPath.row].day
        let minTempDay = day?.mintempC ?? 0.0
        let maxTempDay = day?.maxtempC ?? 0.0
        let iconUrl = day?.condition.icon ?? ""
        let icon = Service.stringToImage(str: iconUrl) ?? UIImage(named: "naicon")
        
        cell.progressView.setProgress(abs(Float(maxTempDay + minTempDay)) / 100, animated: true)
        cell.backgroundColor = UIColor.clear
        cell.dayLabel.text = dayWeek
        cell.weatherImageView.image = icon
        cell.tempMinLabel.text = String(minTempDay.toInt()) + "°"
        cell.tempMaxLabel.text = String(maxTempDay.toInt()) + "°"
        cell.dayLabel.text = dayWeek
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Weekly Weather"
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       tableView.backgroundColor = #colorLiteral(red: 0.1938996013, green: 0.3328887908, blue: 0.3157452245, alpha: 0.1990463361)
   }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

extension WeekTableView: UITableViewDelegate {}

extension WeekTableView: ViewComponentProtocol {
    func reloadData(data: Weather?) {
       weather = data
       tableView.reloadData()
    }
}

extension WeekTableView {
    private func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(self)
        }
    }
}

