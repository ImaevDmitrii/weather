//
//  WeatherModel.swift
//  weather
//
//  Created by Dmitrii Imaev on 22.03.2024.
//

import Foundation

struct WeatherData: Codable {
    let cod: String
    let list: [WeatherInfo]
}

struct WeatherInfo: Codable {
    let dt: TimeInterval
    let main: Main
    let weather: [Weather]
    let wind: Wind
}

struct Main: Codable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    let humidity: Int
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
}
