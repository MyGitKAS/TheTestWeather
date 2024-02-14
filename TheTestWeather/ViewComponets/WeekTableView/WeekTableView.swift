//
//  WeekTableView.swift
//  TheTestWeather
//
//  Created by Aleksey Kuhlenkov on 12.12.23.
//

import UIKit
import SnapKit

protocol WeekTableViewProtocol: ViewComponentProtocol {
    var WeekdifferentTemp: (Float, Float)? { get set }
}

final class WeekTableView: UIView {

    var WeekdifferentTemp: (Float, Float)?
    private let tableView = UITableView()
    private var weather: Weather?
    private  let days = [NSLocalizedString("day_mon", comment: ""),
                         NSLocalizedString("day_tue", comment: ""),
                         NSLocalizedString("day_wed", comment: ""),
                         NSLocalizedString("day_thu", comment: ""),
                         NSLocalizedString("day_fri", comment: ""),
                         NSLocalizedString("day_sat", comment: ""),
                         NSLocalizedString("day_sun", comment: "")]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
        setConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        self.addSubview(tableView)
        self.backgroundColor = UIColor.clear
        tableView.layer.cornerRadius = 20
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(WeekTableViewCell.self, forCellReuseIdentifier: "WeekTableViewCell")
        tableView.isScrollEnabled = false
        tableView.allowsSelection = false
        tableView.backgroundColor = .clear
    }
}

extension WeekTableView: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weather?.forecast.forecastday.count ?? 0
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        if let textlabel = header.textLabel {
            textlabel.font = textlabel.font.withSize(20)
            textlabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeekTableViewCell", for: indexPath) as! WeekTableViewCell
        guard let weather = weather else { return cell }
        let day = weather.forecast.forecastday[indexPath.row].day
        let numberDay = Helper.getNumberDayWeek()
        let indexCell = indexPath.row
        var dayWeek = days[(numberDay + indexCell) % 7]
        let locale = Helper.getLanguage()
       
        let minTempDay = locale == "ru" ? day.mintempC : day.mintempF
        let maxTempDay = locale == "ru" ? day.maxtempC : day.maxtempF
        let currentTemp = locale == "ru" ? weather.current.tempC : weather.current.tempF
        let iconUrl = day.condition.icon
        let iconImage = Helper.stringToImage(str: iconUrl)
        
        let minWeek = WeekdifferentTemp?.0 ?? 0
        let maxWeek = WeekdifferentTemp?.1 ?? 0
        
        if indexCell == 0 {
                 dayWeek = NSLocalizedString("today_label", comment: "")
            cell.scaleView.setParametrs(minWeek: minWeek, maxWeek: maxWeek, minDay: minTempDay, maxDay: maxTempDay, current: (currentTemp))
        } else {
            cell.scaleView.setParametrs(minWeek: minWeek, maxWeek: maxWeek, minDay: minTempDay, maxDay: maxTempDay)
        }

        cell.dayLabel.text = dayWeek
        cell.weatherImageView.image = iconImage
        cell.tempMinLabel.text = String(minTempDay.toInt()) + "°"
        cell.tempMaxLabel.text = String(maxTempDay.toInt()) + "°"
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        NSLocalizedString("week_table_title", comment: "")
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.backgroundColor = #colorLiteral(red: 0.1938996013, green: 0.3328887908, blue: 0.3157452245, alpha: 0.1990463361)
   }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

extension WeekTableView: WeekTableViewProtocol {
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
