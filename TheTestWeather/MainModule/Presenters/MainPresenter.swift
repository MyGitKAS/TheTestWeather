//
//  MainPresenter.swift
//  TheTestWeather
//
//  Created by Aleksey Kuhlenkov on 11.12.23.
//
import UIKit

protocol ViewComponentProtocol: UIView {
    func reloadData(data: Weather)
}

protocol MainViewProtocol: AnyObject {
    func success(dataWeather: Weather)
    func failure()
   // func failure(error: Error)
}

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, networkServise: NetworkServiceProtocol)
    func getWeather()
    var weater: Weather? { get }
   
}

class MainPresenter: MainViewPresenterProtocol {
    
    let view: MainViewProtocol!
    let networkService: NetworkServiceProtocol!
    var weater: Weather?
    
    required init(view: MainViewProtocol, networkServise: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkServise
        
        getWeather()
    }
    
    func getWeather() {
        let city = InfoService.getLocation()
        if InfoService.isInternetAvailable() {
            networkService.parseWeather(city: city) { [self] weather in
                if let dataWeather = weather {
                    print("!1111111111")
                    view.success(dataWeather: dataWeather)
//                    DataStorageService.removeData(forKey: DataStorageService.userKey)
//                    DataStorageService.saveData(try? JSONEncoder().encode(weatherData), forKey: DataStorageService.userKey)
                } else  {
                    view.failure()
                }
            }
        } else {
//            if let data = DataStorageService.loadData(forKey: DataStorageService.userKey) as? Data,
//                let weatherData = try? JSONDecoder().decode(Weather.self, from: data) {
//
//                view.success(getWeather: weatherData)
//                } else {
//                view.failure()
//            }
            
            print("NoINTERNET")
        }
    }
}

