//
//  WeekTableView.swift
//  TheTestWeather
//
//  Created by Aleksey Kuhlenkov on 12.12.23.
//

import UIKit
import SnapKit

class WeekTableView: UIView {
    
    let tableView = UITableView()
    let days = ["ПН", "ВТ", "СР", "ЧТ", "ПТ", "СБ", "ВС"]

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
    }
}

extension WeekTableView: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let numberDay = 5
        let indexCell = indexPath.row
        var day = days[(numberDay + indexCell) % 7]
        if indexCell == 0 {
               day = "Cегодня"
           }
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeekTableViewCell", for: indexPath) as! WeekTableViewCell
        cell.backgroundColor = UIColor.clear
        cell.dayLabel.text = day
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Weekly Weather Here"
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       tableView.backgroundColor = #colorLiteral(red: 0.1938996013, green: 0.3328887908, blue: 0.3157452245, alpha: 0.1990463361)
   }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

extension WeekTableView: UITableViewDelegate {
}

extension WeekTableView: ViewComponentProtocol {
    func setData(data: Weather) {
        //
    }
}

extension WeekTableView {
 private func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(self)
        }
    }
}



//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WeekTableViewCell
//        cell.backgroundColor = UIColor.clear
//
////        let days = ["ПН", "ВТ", "СР", "ЧТ", "ПТ", "СБ", "ВС"]
////
////        let numberDay = 5
////        for index in numberDay...numberDay + 5 {
////            let indexCell = 0
////            let day = days[index % 7]
////
////            cell.dayLabel.text = day
////        }
////
////
////        return cell
