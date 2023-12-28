//
//  InfoService.swift
//  TheTestWeather
//
//  Created by Aleksey Kuhlenkov on 13.12.23.
//

import UIKit
import SystemConfiguration
//import CoreLocation

final class InfoService {
    
    static  func getLocation() -> String {
        return "Minsk"
    }
    
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
    
   static func currentHour() -> Int {
        let currentDate = Date()
        let calendar = Calendar.current
        let currentHour = calendar.component(.hour, from: currentDate)
        return currentHour
    }
}
