//
//  CityTableViewCell.swift
//  weather
//
//  Created by Dmitrii Imaev on 15.03.2024.
//

import UIKit

final class CityTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak private var containerView: UIView!
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherInfoLabel: UILabel!
    
    @IBOutlet weak private var degreezeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configurate()
    }
    
    func configureCity(with city: City, weatherInfo: WeatherInfo?) {
        cityNameLabel.text = city.name
        
        if let weatherInfo = weatherInfo {
            degreezeLabel.text = "\(Int(weatherInfo.main.temp))°C"
            weatherInfoLabel.text = weatherInfo.weather.first?.description ?? ""
        } else {
            degreezeLabel.text = ""
            weatherInfoLabel.text = ""
        }
    }

private func configurate() {
    containerView.layer.borderWidth = 1.5
    containerView.layer.cornerRadius = 8
    containerView.layer.borderColor = UIColor.customGreen.cgColor
    contentView.backgroundColor = .backgroundColor
    
    cityNameLabel.font = .preferredFont(forTextStyle: .title1)
    cityNameLabel.textColor = .customGreen
    
    weatherInfoLabel.font = .preferredFont(forTextStyle: .title1)
    weatherInfoLabel.textColor = .customGreen
    
    degreezeLabel.font = .preferredFont(forTextStyle: .title1)
    degreezeLabel.font = .preferredFont(forTextStyle: .title1)
}
}
