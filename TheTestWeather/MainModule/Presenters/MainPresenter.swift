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

protocol MainViewProtocol: AnyObject {
    func success(dataWeather: Weather?)
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
    var weater: Weather? { get }
    func changeCityButtonTapped()
    func citySelected(city: String)
   
}

final class MainPresenter: MainViewPresenterProtocol {
        
    private let view: MainViewProtocol!
    private let networkService: NetworkServiceProtocol!
    internal var weater: Weather?
    private let chooseCityVC: ChooseCityViewController!
    private let cityDetailVC : CityDetailViewProtocol!
    
    required init(view: MainViewProtocol,
                  chooseCityVC: ChooseCityViewController,
                  networkServise: NetworkServiceProtocol,
                  cityDetailVC: CityDetailViewProtocol) {
        self.view = view
        self.networkService = networkServise
        self.chooseCityVC = chooseCityVC
        self.cityDetailVC = cityDetailVC
        getWeather()
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
        if InfoService.isInternetAvailable() {
            networkService.parseWeather(city: city, days: 1) { [self] weather in
                if let dataWeather = weather {
                    cityDetailVC.reloadData(weatherData: dataWeather)
                } else  {
                    
                }
            }
            
        } else {
            print("No internet")
        }
    }
    
    func getWeather() {
        let city = InfoService.getLocation()
        
        if InfoService.isInternetAvailable() {
            networkService.parseWeather(city: city, days: 10) { [self] weather in
                if let dataWeather = weather {
                    DataStorageService.shared.removeData(with: DataStorageService.userKey)
                    view.success(dataWeather: dataWeather)
                    DataStorageService.shared.saveData(with: DataStorageService.userKey, value: dataWeather)
                } else {
                    view.failure()
                }
            }
        } else {
            DataStorageService.shared.loadData(with: DataStorageService.userKey) { [self] weather in
                if let loadedWeather = weather {
                    view.success(dataWeather: loadedWeather)
                } else {
                    print("Failed to load data")
                }
            }
        }
    }
}

