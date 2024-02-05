//
//  NetworkService.swift
//  TheTestWeather
//
//  Created by Aleksey Kuhlenkov on 11.12.23.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol {
    func parseWeatherName(city: String, days:Int, completion: @escaping (Weather?) -> Void)
    func parseWeatherLatLon(location: CurrentLocation, days:Int, lang: String, completion: @escaping (Weather?) -> Void)
}

final class WeatherAPINetworkService: NetworkServiceProtocol {
  
    private let apiKey = "648bc29bebf7469e895143102232112"
    private let baseURL = "https://api.weatherapi.com/v1/forecast.json?key="
    
    func parseWeatherLatLon(location: CurrentLocation, days: Int = 10,lang: String = "en", completion: @escaping (Weather?) -> Void) {
        let url = baseURL + apiKey + "&q=\(location.lat),\(location.lon)&days=\(days)&lang=\(lang)"
        AF.request(url).responseDecodable(of: Weather.self) { response in
            switch response.result {
            case .success(let weatherResponse):
                let weather = Weather(location: weatherResponse.location, current: weatherResponse.current, forecast: weatherResponse.forecast)
                completion(weather)
            case .failure(let error):
                print(String(describing: error))
                completion(nil)
            }
        }
    }
    
    func parseWeatherName(city: String, days: Int = 10, completion: @escaping (Weather?) -> Void) {
            let url = baseURL + apiKey + "&q=\(city)&days=\(days)"
            AF.request(url).responseDecodable(of: Weather.self) { response in
            switch response.result {
            case .success(let weatherResponse):
                let weather = Weather(location: weatherResponse.location, current: weatherResponse.current, forecast: weatherResponse.forecast)
                completion(weather)
            case .failure(let error):
                print(String(describing: error))
                completion(nil)
            }
        }
    }
}

