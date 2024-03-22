//
//  CityModel.swift
//  weather
//
//  Created by Dmitrii Imaev on 22.03.2024.
//

import Foundation

struct City: Codable {
    let name: String
    let lat: Double
    let lon: Double
    let country: String
    let state: String?
}
