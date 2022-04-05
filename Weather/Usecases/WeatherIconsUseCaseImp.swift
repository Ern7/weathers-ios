//
//  WeatherIconsUseCaseImp.swift
//  Weather
//
//  Created by Ernest Nyumbu on 2022/04/05.
//

import Foundation

final class WeatherIconsUseCaseImp {
    
    static let shared = WeatherIconsUseCaseImp()
    
}

extension WeatherIconsUseCaseImp : WeatherIconsUseCase {
    
    func getWeatherIconName(weatherId: Int) -> String {
        if weatherId < 800 {
            return "rain"
        }
        else if weatherId == 800 {
            return "clear"
        }
        else if weatherId >= 801  {
            return "partlysunny"
        }
        else {
            return "clear"
        }
    }

    
}
