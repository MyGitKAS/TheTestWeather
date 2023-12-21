//
//  NetworkService.swift
//  TheTestWeather
//
//  Created by Aleksey Kuhlenkov on 11.12.23.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol {
       func parseWeather(city: String, days:Int, completion: @escaping (Weather?) -> Void)
}

final class WeatherAPINetworkService: NetworkServiceProtocol {
    
    private let apiKey = "a8e86a08015d4435afd152547231612"
    private let baseURL = "https://api.weatherapi.com/v1/forecast.json?key="
    
    func parseWeather(city: String, days: Int = 10, completion: @escaping (Weather?) -> Void) {
            let url = baseURL + apiKey + "&q=\(city)&days=\(days)"
        print(url)
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

