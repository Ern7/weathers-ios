//
//  CurrentWeatherUseCaseImp.swift
//  Weather
//
//  Created by Ernest Nyumbu on 2022/04/05.
//

import Foundation
import Combine

final class CurrentWeatherUseCaseImp {
    
    static let shared = CurrentWeatherUseCaseImp()
    
    private func getCurrentWeatherWebResource(latitude: Double, longitude: Double, measurementUnit: MeasurementUnit) -> WebResource<CurrentWeather> {
        
        guard let url = URL(string: "\(Constants.AppConfig.BackendUrl)\(OpenWeatherApiEndpoints.weather.rawValue)?apiKey=\(Constants.ApiKeys.OpenWeatherApiKey)&lat=\(latitude)&lon=\(longitude)&units=\(measurementUnit.rawValue)") else {
            fatalError("URL is incorrect!")
        }
        
        return WebResource<CurrentWeather>(url: url)
    }
}

extension CurrentWeatherUseCaseImp: CurrentWeatherUseCase {
    
    func get(latitude: Double, longitude: Double, measurementUnit: MeasurementUnit = MeasurementUnit.metric) -> Future<CurrentWeather, APICallError> {
        return Future { promixe in
            OpenWeatherApiService.shared.load(resource: self.getCurrentWeatherWebResource(latitude: latitude, longitude: longitude, measurementUnit: measurementUnit)) { result in
                switch result {
                case .success(let response):
                    promixe(.success(response))
                case .failure(let error):
                    DebuggingLogger.printData(error)
                    promixe(.failure(error))
                }
            }
        }
    }

}
