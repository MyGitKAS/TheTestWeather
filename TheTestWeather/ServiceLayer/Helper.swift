//
//  InfoService.swift
//  TheTestWeather
//
//  Created by Aleksey Kuhlenkov on 13.12.23.
//

import UIKit
import SystemConfiguration

final class Helper {

    static func getCurrentDayOfWeek() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: currentDate)
    }
    
    static  func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
    
    static func getNumberDayWeek() -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday], from: Date())
        let numbDay = components.weekday
        if numbDay == 1 {
            return 6
        }
        return (numbDay! - 2)
    }

    static func getLanguage() -> String {
        if let preferredLanguageCode = Locale.preferredLanguages.first {
            let firstTwoLetters = String(preferredLanguageCode.prefix(2))
            return firstTwoLetters
        }
        return "en"
    }
    
   static func getCurrentHour() -> Int {
        let currentDate = Date()
        let calendar = Calendar.current
        let currentHour = calendar.component(.hour, from: currentDate)
        return currentHour
    }
    
    static func calculateCurrentWeekTemperature(weather: Weather) -> (min: Float, max: Float) {
        var min: Float = 0
        var max: Float = 0
        let weakWeather = weather.forecast.forecastday
        for day in weakWeather {
            if day.day.mintempC < min {
                min = day.day.maxtempC
            }
            
            if day.day.maxtempC > max {
                max = day.day.maxtempC
            }
        }
        return (min,max)
    }
    
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
