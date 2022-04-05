//
//  ForecastUseCaseImp.swift
//  Weather
//
//  Created by Ernest Nyumbu on 2022/04/05.
//

import Foundation
import Combine

final class ForecastUseCaseImp {
    
    static let shared = ForecastUseCaseImp()
    
    private func getForecastWebResource(latitude: Double, longitude: Double, measurementUnit: MeasurementUnit = MeasurementUnit.metric) -> WebResource<ForecastResponse> {
        
        guard let url = URL(string: "\(Constants.AppConfig.BackendUrl)\(OpenWeatherApiEndpoints.forecast.rawValue)?apiKey=\(Constants.ApiKeys.OpenWeatherApiKey)&lat=\(latitude)&lon=\(longitude)&units=\(measurementUnit.rawValue)") else {
            fatalError("URL is incorrect!")
        }
        
        return WebResource<ForecastResponse>(url: url)
    }
}

extension ForecastUseCaseImp: ForecastUseCase {
    
    func get(latitude: Double, longitude: Double, measurementUnit: MeasurementUnit = MeasurementUnit.metric) -> Future<ForecastResponse, APICallError> {
        return Future { promixe in
            OpenWeatherApiService.shared.load(resource: self.getForecastWebResource(latitude: latitude, longitude: longitude, measurementUnit: measurementUnit)) { result in
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
