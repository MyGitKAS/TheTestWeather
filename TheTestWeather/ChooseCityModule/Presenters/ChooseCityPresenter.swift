//
//  ChooseCityPresenter.swift
//  TheTestWeather
//
//  Created by Aleksey Kuhlenkov on 14.12.23.
//

//import UIKit
//
//protocol ChooseCityPresenterPresenterProtocol: AnyObject {
//    init(view: ChooseCityViewProtocol,cityDetailView: CityDetailViewProtocol, networkServise: NetworkServiceProtocol)
//    func getWeather(city: String)
//    var weater: Weather? { get }
//    func citySelected(city: String)
//
//}
//
//class ChooseCityPresenter: ChooseCityPresenterPresenterProtocol {
//    
//    let view: ChooseCityViewProtocol!
//    let cityDetailView : CityDetailViewProtocol!
//    let networkService: NetworkServiceProtocol!
//    var weater: Weather?
//    
//    required init(view: ChooseCityViewProtocol, cityDetailView: CityDetailViewProtocol, networkServise: NetworkServiceProtocol) {
//        self.view = view
//        self.networkService = networkServise
//        self.cityDetailView = cityDetailView
//    }
//    
//    func citySelected(city: String) {
//        
//    }
//    
//    func getWeather(city: String) {
//        //let city = InfoService.getLocation()
//        if InfoService.isInternetAvailable() {
//            networkService.parseWeather(city: city) { [self] weather in
//                if let dataWeather = weather {
//                    print("!1111111111")
//                    
//                    
//                }
//            }
//        } else {
//            print("NoINTERNET")
//        }
//    }
//}
