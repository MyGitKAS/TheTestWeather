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
        tableView.backgroundColor = .clear
    }
}

extension WeekTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weather?.forecast.forecastday.count ?? 0
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        if let textlabel = header.textLabel {
            textlabel.font = textlabel.font.withSize(15)
            textlabel.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeekTableViewCell", for: indexPath) as! WeekTableViewCell
        guard let day = weather?.forecast.forecastday[indexPath.row].day else { return cell }
        let numberDay = InfoService.getNumberDayWeek()
        let indexCell = indexPath.row
        var dayWeek = days[(numberDay + indexCell) % 7]
        if indexCell == 0 {
                 dayWeek = NSLocalizedString("today_label", comment: "")
                }
        let locale = InfoService.getLanguage()
       
        let minTempDay = locale == "ru" ? day.mintempC : day.mintempF
        let maxTempDay = locale == "ru" ? day.maxtempC : day.maxtempF
        let iconUrl = day.condition.icon
        let iconImage = Service.stringToImage(str: iconUrl)
       
        cell.progressView.setProgress(abs(Float(maxTempDay + minTempDay)) / 10, animated: true)
       
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
