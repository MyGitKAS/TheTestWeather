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

class FirstModuleBuilder: Builder {
    static func createMain() -> UIViewController {
        let view = MainViewController()
        let networkServise = WeatherAPINetworkService()
        let presenter = MainPresenter(view: view, networkServise: networkServise)
        let currentWeatherView = CurrentWeatherView()
        let dayCoruselView = DayCoruselView()
        let weekTableView = WeekTableView()
        view.currentWeather = currentWeatherView
        view.presenter = presenter
        view.dayCorusel = dayCoruselView
        view.weekTable = weekTableView
        return view
    }
    
    
}
