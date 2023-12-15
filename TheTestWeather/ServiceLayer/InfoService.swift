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
        let date = Date()
        return calendar.component(.weekday, from: date) - 2
    }
    
    static func calculateTime(hours: Int) -> Int {
        let currentDate = Date()
        let calendar = Calendar.current
        let futureDate = calendar.date(byAdding: .hour, value: hours, to: currentDate)
        
        let hour = calendar.component(.hour, from: futureDate!)
        
        return hour
    }
}
