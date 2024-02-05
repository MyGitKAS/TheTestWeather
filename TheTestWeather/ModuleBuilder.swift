//
//  ModuleBuilder.swift
//  TheTestWeather
//
//  Created by Aleksey Kuhlenkov on 11.12.23.
//


import UIKit

protocol Builder {
    static func createMain() -> UIViewController
}

class ModuleBuilder: Builder {
    static func createMain() -> UIViewController {
        let view = MainViewController()
        let networkServise = WeatherAPINetworkService()
        let chooseCityVC = ChooseCityViewController()
        let cityDetailVC = CityDetailViewController()
        let presenter = MainPresenter(
            view: view,
            chooseCityVC: chooseCityVC ,
            networkServise: networkServise,
            cityDetailVC: cityDetailVC)
        let currentWeatherView = CurrentWeatherView()
        let dayCoruselView = DayCoruselView()
        let weekTableView = WeekTableView()
        chooseCityVC.presenter = presenter
        view.currentWeather = currentWeatherView
        view.presenter = presenter
        view.dayCorusel = dayCoruselView
        view.weekTable = weekTableView
        return view
    }
}
