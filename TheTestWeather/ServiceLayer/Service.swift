//
//  Service.swift
//  TheTestWeather
//
//  Created by Aleksey Kuhlenkov on 14.12.23.
//

import UIKit

final class Service {
    static func stringToImage(str: String) -> UIImage? {
       let stringUrl = "https:" + str
        guard let url = URL(string: stringUrl),
              let data = try? Data(contentsOf: url),
              let image = UIImage(data: data) else {
            return UIImage(named: "naicon")
        }
        return image
    }
    
  static func calculateDataAge(from dateString: String) -> String {
        let dateFormat = "yyyy-MM-dd HH:mm"
        let currentDate = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        guard let inputDate = dateFormatter.date(from: dateString) else {
            return "No date"
        }
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([.minute, .hour, .day], from: inputDate, to: currentDate)
      
        if let days = components.day, days > 0 {
            let dayAgoLabel = NSLocalizedString("days_ago_label", comment: "")
            return "\(days) \(dayAgoLabel)"
        }
        if let hours = components.hour, hours < 24 && hours > 0 {
            let hoursAgoLabel = NSLocalizedString("hours_ago_label", comment: "")
            return "\(hours) \(hoursAgoLabel)"
        }
        if let minutes = components.minute, minutes < 60 {
            let minutesAgoLabel = NSLocalizedString("min_ago_label", comment: "")
            return "\(minutes) \(minutesAgoLabel)"
        }
        return "Unknow"
    }
}


