//
//  CitysTableViewController.swift
//  weather
//
//  Created by Dmitrii Imaev on 15.03.2024.
//

import UIKit

final class CitysTableViewController: UITableViewController {
    
    @IBOutlet weak var seatchBar: UISearchBar!
    
    private let viewModel = CitysViewModel()
    private var filteredCities: [City] = []
    private let cellId = String(describing: CityTableViewCell.self)
    private let numberOfSection = 1
    private let rowHeight: CGFloat = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        fetchInitialCities()
        seatchBar.delegate = self
    }
    
    func configureTableView() {
        tableView.backgroundColor = .backgroundColor
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = rowHeight
        tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
    }
    
    func fetchInitialCities() {
        let citiesToSearch = ["Istanbul", "Madrid", "Belgrad", "Paris", "Roma"]
        
        for city in citiesToSearch {
            viewModel.searchCity(for: city) { result in
                switch result {
                case .success(let cities):
                    print(cities)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

// MARK: - Table view data source

extension CitysTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        numberOfSection
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredCities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? CityTableViewCell else { return UITableViewCell() }
        
        let city = filteredCities[indexPath.row]
        let weatherInfo = viewModel.cityWeatherMap[city.name]
        cell.configureCity(with: city, weatherInfo: weatherInfo)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        rowHeight
    }
}

// MARK: - UISeatchBarDelegate

extension CitysTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            filteredCities = viewModel.cities
            tableView.reloadData()
            return
        }
        viewModel.searchCity(for: searchText) { result in
            switch result {
            case .success(let cities):
                self.filteredCities = cities
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Error searching for cities: \(error)")
            }
        }
    }
}

