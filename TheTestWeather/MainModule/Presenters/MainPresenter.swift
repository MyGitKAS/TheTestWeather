//
//  MainPresenter.swift
//  TheTestWeather
//
//  Created by Aleksey Kuhlenkov on 11.12.23.
//

import UIKit

protocol ViewComponentProtocol: UIView {
    func reloadData(data: Weather?)
}

enum DataFrom {
    case network
    case storage
}

protocol MainViewProtocol: AnyObject {
    func success(dataWeather: Weather?,from: DataFrom, WeekDifferentTemp: (Float, Float))
    func failure()
    func presenVC(vc: UIViewController)
}

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol,
         chooseCityVC: ChooseCityViewController,
         networkServise: NetworkServiceProtocol,
         cityDetailVC: CityDetailViewProtocol
    )
    
    func getWeather()
    func changeCityButtonTapped()
    func citySelected(city: String)
   
}

final class MainPresenter: MainViewPresenterProtocol {
    
    weak private var view: MainViewProtocol!
    weak private var chooseCityVC: ChooseCityViewController!
    weak private var cityDetailVC: CityDetailViewProtocol!
    private let networkService: NetworkServiceProtocol!
    private var currentLocation: CurrentLocation?
    
    required init(view: MainViewProtocol,
                  chooseCityVC: ChooseCityViewController,
                  networkServise: NetworkServiceProtocol,
                  cityDetailVC: CityDetailViewProtocol) {
        self.view = view
        self.networkService = networkServise
        self.chooseCityVC = chooseCityVC
        self.cityDetailVC = cityDetailVC
        getCurrentLocationWeather()
    }
    
    private func getCurrentLocationWeather() {
        LocationService.shared.requestLocation { [weak self] location in
            guard location != nil else { self?.currentLocation = CurrentLocation(lat: 53.893009, lon: 27.567444); return }
            self?.currentLocation = CurrentLocation(lat: location!.lat, lon: location!.lon )
            self?.getWeather()
        }
    }
    
    func changeCityButtonTapped() {
        view.presenVC(vc: chooseCityVC)
    }
    
    func citySelected(city: String) {
        chooseCityVC.closeSelf()
        let vc = cityDetailVC
        getOneCity(city: city)
        view.presenVC(vc: vc as! UIViewController)
    }
    
    func getOneCity(city: String) {
        if Helper.isInternetAvailable() {
            networkService.parseWeatherName(city: city, days: 1) { [self] weather in
                guard let dataWeather = weather else { return }
                cityDetailVC.reloadData(weatherData: dataWeather)
            }
        }
    }

    func getWeather() {
        if Helper.isInternetAvailable() {
            let localeLanguage = Helper.getLanguage()
            networkService.parseWeatherLatLon(location: currentLocation!, days: 7, lang: localeLanguage) { [self] weather in
                if let dataWeather = weather {
                    DataStorageService.shared.removeData(with: DataStorageService.userKey)
                    DataStorageService.shared.saveData(with: DataStorageService.userKey, value: dataWeather)
                    let weekDifferentTemp = Helper.calculateCurrentWeekTemperature(weather: dataWeather)
                    view.success(dataWeather: dataWeather, from: .network, WeekDifferentTemp: weekDifferentTemp)
                }
            }
        } else {
            DataStorageService.shared.loadData(with: DataStorageService.userKey) { [self] weather in
                if let loadedWeather = weather {
                    let weekDifferentTemp = Helper.calculateCurrentWeekTemperature(weather: loadedWeather)
                    view.success(dataWeather: loadedWeather, from: .storage, WeekDifferentTemp: weekDifferentTemp)
                } else {
                    print("Failed to load data")
                }
            }
        }
    }
}

