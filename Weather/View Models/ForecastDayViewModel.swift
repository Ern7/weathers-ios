//
//  ForecastDayViewModel.swift
//  Weather
//
//  Created by Ernest Nyumbu on 2022/04/05.
//

import Foundation

struct ForecastDayViewModel {
    private let forecastDay: ForecastDay
    private let dateFormatter = DateFormatter()
    
    //UseCases
    private let measurementUnitSettingsUseCase = MeasurementUnitSettingsUseCaseImp.shared
    private let measurementUnitDisplayUseCase = MeasurementUnitDisplayUseCaseImp.shared
    private let weatherIconsUseCase = WeatherIconsUseCaseImp.shared
}

extension ForecastDayViewModel {
    init(_ forecastDay: ForecastDay) {
        self.forecastDay = forecastDay
    }
}

extension ForecastDayViewModel {
    
    var day: String {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: self.forecastDay.dateText)
        
        dateFormatter.dateFormat = "EEEE"
        let friendlyDate = dateFormatter.string(from: date!)
        return friendlyDate
    }
    
    var iconName: String {
        let iconName = self.weatherIconsUseCase.getWeatherIconName(weatherId: self.forecastDay.weatherId)
        return iconName
    }
    
    var temperature: String {
        if let _temperature = self.forecastDay.temperature {
            let temp = Int(round(_temperature))
            let savedUserMeasurementUnit = measurementUnitSettingsUseCase.get()
            let unit = measurementUnitDisplayUseCase.getTemperatureUnitDisplayText(measurementUnit: savedUserMeasurementUnit)
            return "\(temp)\(unit)"
        }
        return "N/A"
    }
    
}
