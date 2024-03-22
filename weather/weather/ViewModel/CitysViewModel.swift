//
//  CitysViewModel.swift
//  weather
//
//  Created by Dmitrii Imaev on 15.03.2024.
//

import Foundation

final class CitysViewModel {
    
    var cities: [City] = []
    var cityWeatherMap: [String: WeatherInfo] = [:]
    
    private let networkService = NetworkService()
    
    func searchCity(for cityName: String, completion: @escaping (Result<[City], Error>) -> Void) {
        networkService.searchCity(cityName) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let cities):
                self.cities = cities
                completion(.success(cities))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchWeather(for city: City, completion: @escaping (Result<WeatherInfo, Error>) -> Void) {
        networkService.fetchWeather(latitude: city.lat, longitude: city.lon) { result in
            switch result {
            case .success(let weatherData):
                guard let weatherInfo = weatherData.list.first else {
                    completion(.failure(NetworkService.NetworError.decodingError))
                    return
                }
                completion(.success(weatherInfo))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchWeatherForCities(for cities: [City], completion: @escaping (Result<Void, Error>) -> Void) {
        var successCount = 0
        
        for city in cities {
            networkService.fetchWeather(latitude: city.lat, longitude: city.lon) { result in
                switch result {
                case .success(let weatherData):
                    guard let weatherInfo = weatherData.list.first else {
                        completion(.failure(NetworkService.NetworError.decodingError))
                        return
                    }
                    self.cityWeatherMap[city.name] = weatherInfo
                    successCount += 1
                    
                    // Проверяем, получили ли данные о погоде для всех городов
                    if successCount == cities.count {
                        completion(.success(()))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
