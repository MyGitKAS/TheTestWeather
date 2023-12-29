//
//  LocationService.swift
//  TheTestWeather
//
//  Created by Aleksey Kuhlenkov on 28.12.23.
//

//

import UIKit
import CoreLocation

class LocationService: NSObject {
    static let shared = LocationService()
    private var locationManager: CLLocationManager?
    private var currentLocation: CLLocation?
    private var cityCompletionHandler: ((CurrentLocation?) -> Void)?

    private override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
    }
    
    func requestLocation(completion: @escaping (CurrentLocation?) -> Void) {
           cityCompletionHandler = completion
           locationManager?.requestWhenInUseAuthorization()
           locationManager?.startUpdatingLocation()
       }
}

extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            cityCompletionHandler?(nil)
            return
        }
        locationManager?.stopUpdatingLocation()
        DispatchQueue.global().async {
            let currentLocale = CurrentLocation(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
            
            DispatchQueue.main.async {
                self.cityCompletionHandler?(currentLocale)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location: \(error.localizedDescription)")
        cityCompletionHandler?(nil)
    }
}




