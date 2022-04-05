//
//  WeatherIconsUseCase.swift
//  Weather
//
//  Created by Ernest Nyumbu on 2022/04/05.
//

import Foundation

protocol WeatherIconsUseCase {
    func getWeatherIconName(weatherId: Int) -> String
}
