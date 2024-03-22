//
//  NetworkService.swift
//  weather
//
//  Created by Dmitrii Imaev on 22.03.2024.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchWeather(latitude: Double, longitude: Double, completion: @escaping (Result<WeatherData, Error>) -> Void)
    func searchCity(_ cityName: String, completion: @escaping (Result<[City], Error>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    
    private let apiKey = "18512b9aaaadbdeb23eaa3226f5ff8c9"
    
    enum NetworError: Error {
        case invalidURL
        case dataNotReceived
        case decodingError
    }
    
    func fetchWeather(latitude: Double, longitude: Double, completion: @escaping (Result<WeatherData, Error>) -> Void) {
        let urlString = "api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworError.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(NetworError.dataNotReceived))
                return
            }
            do {
                let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                completion(.success(weatherData))
            } catch {
                completion(.failure(NetworError.decodingError))
            }
        }.resume()
    }
    
    func searchCity(_ cityName: String, completion: @escaping (Result<[City], Error>) -> Void) {
        let formattedCityName = cityName.replacingOccurrences(of: " ", with: "%20")
        let urlString = "https://api.openweathermap.org/geo/1.0/direct?q=\(formattedCityName)&limit=5&appid=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(NetworError.dataNotReceived))
                return
            }
            
            do {
                let cities = try JSONDecoder().decode([City].self, from: data)
                completion(.success(cities))
            } catch {
                completion(.failure(NetworError.decodingError))
            }
        }.resume()
    }
}
