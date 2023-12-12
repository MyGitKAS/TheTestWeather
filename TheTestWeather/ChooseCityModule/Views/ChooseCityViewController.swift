//
//  ChooseCityViewController.swift
//  TheTestWeather
//
//  Created by Aleksey Kuhlenkov on 13.12.23.
//

import UIKit

class ChangeCityViewController: UIViewController{

    let searchBar = UISearchBar()
    let tableView = UITableView()
    private let buttonEmpty = UIButton()
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
        setupButtonEmpty()
        setupTableView()
    }
    
    private func setupButtonEmpty() {
        view.addSubview(buttonEmpty)
        buttonEmpty.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 200)
        buttonEmpty.addTarget(self, action: #selector(buttonTouch), for: .touchUpInside)
    }
    
    private func setupTableView() {
        tableView.frame = CGRect(x: 0, y: 249, width: view.frame.width, height: view.frame.height - 50)
        tableView.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
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
        searchBar.barTintColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        searchBar.delegate = self
        searchBar.backgroundColor = .green
        searchBar.delegate = self
    }
    
    @objc func buttonTouch() {
        self.dismiss(animated: true)
    }
}

extension ChangeCityViewController: UISearchBarDelegate {
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

extension ChangeCityViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        let vc = CityDetailViewController()
        self.present(vc, animated: true)
        //self.dismiss(animated: false)
    }
    
}
