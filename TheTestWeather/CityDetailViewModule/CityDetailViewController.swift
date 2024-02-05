//
//  CityDetailViewController.swift
//  TheTestWeather
//
//  Created by Aleksey Kuhlenkov on 12.12.23.
//

import UIKit
import SnapKit

protocol CityDetailViewProtocol {
    func reloadData(weatherData: Weather)
}

class CityDetailViewController: UIViewController {
    
    let currentTemp = UILabel()
    let icon = UIImageView ()
    private let backButton = UIButton(type: .roundedRect)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupComponents()
        setConstraints()
    }
    
    private func setupView() {
        view.backgroundColor = .systemIndigo
    }
    
    private func setupComponents() {
        view.addSubview(currentTemp)
        view.addSubview(icon)
        view.addSubview(backButton)
        currentTemp.isWhite()
        currentTemp.font = UIFont.systemFont(ofSize: 70)
        setupBackButton()
        
    }
    
    private func setupBackButton() {
        let title = NSLocalizedString("back_button", comment: "")
        backButton.setTitle(title, for: .normal)
        backButton.setTitleColor(.white, for: .normal)
        backButton.layer.cornerRadius = 20
        backButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.2013747027)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    @objc func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension CityDetailViewController {

    func setConstraints() {
        currentTemp.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(200)
        }
        icon.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(currentTemp.snp.bottom).offset(20)
            make.height.width.equalTo(110)
        }
        backButton.snp.makeConstraints { make in
            make.top.equalTo(icon.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
    }
}

extension CityDetailViewController: CityDetailViewProtocol{
    func reloadData(weatherData: Weather) {
        let locale = InfoService.getLanguage()
        let temperature = locale == "ru" ? weatherData.current.tempC : weatherData.current.tempF
        let designationTemp = NSLocalizedString("designation_temp", comment: "")
        currentTemp.text = String(Int(temperature)) + designationTemp
        let iconUrl = weatherData.current.condition.icon
        self.icon.image = Service.stringToImage(str: iconUrl) ??  UIImage(named: "naicon")
      
    }
}
