//
//  TimeStampDataViewModel.swift
//  Weather
//
//  Created by Ernest Nyumbu on 2022/04/05.
//

import Foundation

struct TimeStampDataViewModel {
    private let timeStampData: TimeStampData
    private let weatherIconsUseCase = WeatherIconsUseCaseImp.shared
}

extension TimeStampDataViewModel {
    init(_ timeStampData: TimeStampData) {
        self.timeStampData = timeStampData
    }
}

extension TimeStampDataViewModel {
    
    var dateTime: String {
        return self.timeStampData.dtTxt
    }
    
    var temperature: Double {
        if let _temperature = self.timeStampData.main.temp {
            return _temperature
        }
        return 0
    }
    
    var weatherIcon: String {
        if self.timeStampData.weather.count > 0 {
            let weatherId = self.timeStampData.weather[0].id
            return weatherIconsUseCase.getWeatherIconName(weatherId: weatherId)
        }
        return ""
    }
    
}
