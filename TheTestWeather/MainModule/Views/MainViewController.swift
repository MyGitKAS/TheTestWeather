//
//  ViewController.swift
//  TheTestWeather
//
//  Created by Aleksey Kuhlenkov on 11.12.23.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {

    var presenter: MainViewPresenterProtocol!
    var currentWeather: ViewComponentProtocol!
    var dayCorusel: ViewComponentProtocol!
    var weekTable: ViewComponentProtocol!
    lazy var lastUpdateLabel = UILabel()
    private let changeCityButton = UIButton(type: .roundedRect)
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
        setupChangeCityButton()
        setGradient()
    }
    
    private func setGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [ UIColor.cyan.cgColor,
                                UIColor.systemPurple.cgColor,
                                UIColor.blue.cgColor]
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setupView() {
        lastUpdateLabel.isExclusiveTouch = true
        view.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        view.addSubview(currentWeather)
        view.addSubview(changeCityButton)
        view.addSubview(dayCorusel)
        view.addSubview(weekTable)
        view.addSubview(lastUpdateLabel)
    }
    
    private func setupChangeCityButton() {
        let title = NSLocalizedString("change_button_text", comment: "")
        changeCityButton.setTitle(title, for: .normal)
        changeCityButton.setTitleColor(.white, for: .normal)
        changeCityButton.layer.cornerRadius = 20
        changeCityButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.2013747027)
        changeCityButton.addTarget(self, action: #selector(changeCityButtonTapped), for: .touchUpInside)
    }
    
    private func showLastUpdateLabel(howLong: String) {
        lastUpdateLabel.text = "Last update: \(howLong)."
        lastUpdateLabel.font = UIFont.systemFont(ofSize: 14)
        lastUpdateLabel.textAlignment = .center
        lastUpdateLabel.textColor = .red
        lastUpdateLabel.isHidden = false
    }

    @objc func changeCityButtonTapped() {
        presenter.changeCityButtonTapped()
    }
}

extension MainViewController: MainViewProtocol {
    func presenVC(vc: UIViewController) {
         present(vc, animated: true)
    }
    
    func success(dataWeather: Weather?, from: DataFrom) {
        currentWeather.reloadData(data: dataWeather)
        dayCorusel.reloadData(data: dataWeather)
        weekTable.reloadData(data: dataWeather)
        
        guard from == .storage else { return }
        guard let data = dataWeather else { return }
        let lastUpdate = data.current.lastUpdated
        let dataAge = Service.calculateDataAge(from: lastUpdate)
        showLastUpdateLabel(howLong: dataAge)
        
    }
    
    func failure() {
        let alert = UIAlertController(title: "No Internet connection", message: "Check your connection", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
}

extension MainViewController {

    func setConstraints() {
        currentWeather.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(90)
        }
        changeCityButton.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.top.equalTo(currentWeather.snp_bottomMargin).offset(30)
        }
        lastUpdateLabel.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.top.equalTo(changeCityButton.snp_bottomMargin).offset(15)
        }
        dayCorusel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(lastUpdateLabel.snp_bottomMargin).offset(15)
            make.height.equalTo(130)
            make.trailing.equalToSuperview().inset(20)
            make.leading.equalToSuperview().offset(20)
        }
        weekTable.snp.makeConstraints { make in
            make.top.equalTo(dayCorusel.snp.bottom).offset(10)
            make.height.equalTo(330)
            make.trailing.equalToSuperview().inset(20)
            make.leading.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()

        }
    }
}

