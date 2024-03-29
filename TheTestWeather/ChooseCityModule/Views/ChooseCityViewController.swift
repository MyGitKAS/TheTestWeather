//
//  ChooseCityViewController.swift
//  TheTestWeather
//
//  Created by Aleksey Kuhlenkov on 13.12.23.
//

import UIKit

protocol ChooseCityViewProtocol: AnyObject {
    func closeSelf()
}

final class ChooseCityViewController: UIViewController {
    var presenter: MainViewPresenterProtocol!
    private let searchBar = UISearchBar()
    private let tableView = UITableView()
    private let buttonBackTopBackground = UIButton()
    private var isSearching = false

    private let cityArray = [ "Minsk","Amsterdam","Tokio","Bangkok","London",
                         "Brest","Washington","Berlin","Madrid","Delhi",
                         "Florence","Barcelona","Paris","Havana","Moscow",
                          "Oslo","Toronto","Chicago","Karaganda",
                         "Mumbai","Athens"]
    
    private var filteredCityArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupButtonBackTopBackground()
        setupTableView()
    }
    
    private func setupButtonBackTopBackground() {
        view.addSubview(buttonBackTopBackground)
        buttonBackTopBackground.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 200)
        buttonBackTopBackground.addTarget(self, action: #selector(buttonTouch), for: .touchUpInside)
    }
    
    private func setupTableView() {
        tableView.frame = CGRect(x: 0, y: 249, width: view.frame.width, height: view.frame.height - 249)
        tableView.backgroundColor = #colorLiteral(red: 0.3608969322, green: 0.6447784096, blue: 0.9686274529, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    private func setupSearchBar() {
        view.addSubview(searchBar)
        searchBar.frame = CGRect(x: 0, y: 200, width: view.frame.width, height: 50)
        searchBar.placeholder = "Enter city"
        searchBar.isTranslucent = false
        searchBar.searchTextField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.2975988064)
        searchBar.barTintColor = #colorLiteral(red: 0.3608969322, green: 0.6447784096, blue: 0.9686274529, alpha: 1)
        searchBar.delegate = self
        searchBar.backgroundColor = .green
        searchBar.delegate = self
    }
    
    @objc func buttonTouch() {
        self.dismiss(animated: true)
    }
}

extension ChooseCityViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.filteredCityArray.removeAll()
        
        guard searchText != "" || searchText != " " else {
            print("empty search")
            return
        }
        
        for item in cityArray {
            let text = searchText.lowercased()
            let isArrayContain = item.lowercased().range(of: text)
            if isArrayContain != nil {
                print("Search complete")
                filteredCityArray.append(item)
            }
        }
        
        if searchBar.text == "" {
                  isSearching = false
                  tableView.reloadData()
              } else {
                  isSearching = true
                  filteredCityArray = cityArray.filter({$0.contains(searchBar.text ?? "")})
                  tableView.reloadData()
              }
          }
      }

extension ChooseCityViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredCityArray.count
        } else {
            return cityArray.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        if isSearching {
            cell.textLabel?.text = filteredCityArray[indexPath.row]
        } else {
            cell.textLabel?.text = cityArray[indexPath.row]
        }
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          let selectedCell = tableView.cellForRow(at: indexPath)
          if let cityName = selectedCell?.textLabel?.text {
              presenter.citySelected(city: cityName)
          }
    }
}

extension ChooseCityViewController: ChooseCityViewProtocol {
    func closeSelf() {
        self.dismiss(animated: false, completion: nil)
    }
}
