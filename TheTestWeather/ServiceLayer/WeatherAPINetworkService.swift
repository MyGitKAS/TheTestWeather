//
//  NetworkService.swift
//  TheTestWeather
//
//  Created by Aleksey Kuhlenkov on 11.12.23.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol {
       func parseWeather(city: String, completion: @escaping (Weather?) -> Void)
}

class WeatherAPINetworkService: NetworkServiceProtocol {

        func parseWeather(city: String, completion: @escaping (Weather?) -> Void) {

            let url = "https://api.weatherapi.com/v1/forecast.json?key=cbd221c15409491b8e8164754231012&q=\(city)"

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

