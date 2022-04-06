//
//  CurrentWeatherViewModel.swift
//  Weather
//
//  Created by Ernest Nyumbu on 2022/04/05.
//

import Foundation
import Combine

class CurrentWeatherViewModel : BaseViewModel {
    private var currentWeather: CurrentWeather?
    
    //UseCases
    private let measurementUnitSettingsUseCase = MeasurementUnitSettingsUseCaseImp.shared
    private let measurementUnitDisplayUseCase = MeasurementUnitDisplayUseCaseImp.shared
    private let currentWeatherUseCase = CurrentWeatherUseCaseImp.shared
    
}

extension CurrentWeatherViewModel {
    func fetchCurrentWeather(latitude : Double, longitude : Double){
        self.needsToShowLoading?()
        let measurementUnit = measurementUnitSettingsUseCase.get()
        currentWeatherUseCase.get(latitude: latitude, longitude: longitude, measurementUnit: measurementUnit)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    DebuggingLogger.printData("fetchCurrentWeather finished")
                case .failure(let error):
                    DebuggingLogger.printData("fetchCurrentWeather results error: \(error.message)")
                    self.needsToShowError?(error)
                }
            }, receiveValue: { [weak self] value in
                DebuggingLogger.printData("fetchCurrentWeather results: \(value)")
                self?.currentWeather = value
                self?.needsToUpdateViewWithNewData?()
            }).store(in: &observers)
    }
}


extension CurrentWeatherViewModel {
    
    var currentTemperature: String {
        if let _temperature = self.currentWeather!.main.temp {
            let temp = Int(round(_temperature))
            let savedUserMeasurementUnit = measurementUnitSettingsUseCase.get()
            let unit = measurementUnitDisplayUseCase.getTemperatureUnitDisplayText(measurementUnit: savedUserMeasurementUnit)
            return "\(temp)\(unit)"
        }
        return "N/A"
    }
    
    var minimumTemperature: String {
        if let _temperature = self.currentWeather!.main.tempMin {
            let temp = Int(round(_temperature))
            let savedUserMeasurementUnit = measurementUnitSettingsUseCase.get()
            let unit = measurementUnitDisplayUseCase.getTemperatureUnitDisplayText(measurementUnit: savedUserMeasurementUnit)
            return "\(temp)\(unit)"
        }
        return "N/A"
    }
    
    var maxTemperature: String {
        if let _temperature = self.currentWeather!.main.tempMax {
            let temp = Int(round(_temperature))
            let savedUserMeasurementUnit = measurementUnitSettingsUseCase.get()
            let unit = measurementUnitDisplayUseCase.getTemperatureUnitDisplayText(measurementUnit: savedUserMeasurementUnit)
            return "\(temp)\(unit)"
        }
        return "N/A"
    }
    
    var title: String {
        if self.currentWeather!.weather.count > 0 {
            return self.currentWeather!.weather[0].main.uppercased()
        }
        return ""
    }
    
    var pageBackgroundColor: String {
        if self.currentWeather!.weather.count > 0 {
            return currentWeatherUseCase.getPageBackgroundColorHex(weatherId: self.currentWeather!.weather[0].id)
        }
        return Constants.AppPalette.sunnyPageBackgroundGreen
    }
    
    var pageBackgroundImageName: String {
        if self.currentWeather!.weather.count > 0 {
            return currentWeatherUseCase.getHeaderBackgroundImageName(weatherId: self.currentWeather!.weather[0].id)
        }
        return Constants.CurrentWeatherBackgroundImageNames.forestSunny
    }
    
    func getHeaderHeight(viewWidth: Double) -> Double {
        return currentWeatherUseCase.getHomeHeaderHeight(viewWidth: viewWidth)
    }
}
