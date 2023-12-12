//
//  MainPresenter.swift
//  TheTestWeather
//
//  Created by Aleksey Kuhlenkov on 11.12.23.
//
import UIKit

protocol ViewComponentProtocol: UIView {
     
    func setData(data: Weather)
}

protocol MainViewProtocol: AnyObject {
    func succes(getWeather: Weather)
    func failure(error: Error)
}

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, networkServise: NetworkServiceProtocol)
    func getWeather()
    var weater: Weather? { get }
   
}

class MainPresenter: MainViewPresenterProtocol {
    
    let view: MainViewProtocol!
    let networkServise: NetworkServiceProtocol!
    var weater: Weather?
    
    
    required init(view: MainViewProtocol, networkServise: NetworkServiceProtocol) {
        self.view = view
        self.networkServise = networkServise
    }
    
    func getWeather() {
        networkServise.parseWeather(city:"London" ) { weater in
            if weater != nil {
                print(weater?.location ?? "")
            }
        }
    }
    
    func locale() {
        let currentLocale = NSLocale.current
        let localeIdentifier = currentLocale.identifier
        let languageCode = currentLocale.languageCode
        let regionCode = currentLocale.regionCode
        let city = currentLocale.localizedString(forRegionCode: regionCode ?? "")
        
        print(city)
        print("Locale Identifier: \(localeIdentifier)")
        print("Language Code: \(languageCode ?? "")")
        print("Region Code: \(regionCode ?? "")")
    }
    


}

