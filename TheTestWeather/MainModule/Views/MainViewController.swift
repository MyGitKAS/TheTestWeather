//
//  ViewController.swift
//  TheTestWeather
//
//  Created by Aleksey Kuhlenkov on 11.12.23.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    var presenter: MainViewPresenterProtocol!
    var currentWeather: ViewComponentProtocol!
    let changeCityButton = UIButton(type: .roundedRect)
    var dayCorusel: ViewComponentProtocol!
    var weekTable: ViewComponentProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
        setupChangeCityButton()
        
    }
    
    
    private func setupView() {
        view.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        view.addSubview(currentWeather)
        view.addSubview(changeCityButton)
        view.addSubview(dayCorusel)
        view.addSubview(weekTable)
    }
    
    private func setupChangeCityButton() {
        changeCityButton.setTitle("Change City", for: .normal)
        changeCityButton.setTitleColor(.white, for: .normal)
        changeCityButton.layer.cornerRadius = 20
        changeCityButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.2013747027)
//        changeCityButton.addTarget(self, action: #selector(changeCityButtonTapped), for: .touchUpInside)
    }

}

extension MainViewController: MainViewProtocol {
    
    func succes(getWeather: Weather) {
        //
    }
    
    func failure(error: Error) {
        //
    }

}

extension MainViewController {

    func setConstraints() {
        currentWeather.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(100)
        }
        changeCityButton.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.top.equalTo(currentWeather.snp_bottomMargin).offset(10)
        }
        dayCorusel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(changeCityButton.snp_bottomMargin).offset(80)
            make.height.equalTo(130)
            make.width.equalTo(350)
        }
        weekTable.snp.makeConstraints { make in
            make.top.equalTo(dayCorusel.snp.bottom).offset(10)
            make.width.equalTo(350)
            make.height.equalTo(330)
            make.centerX.equalToSuperview()

        }
    }
}