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
    
    func getPageBackgroundColorHex(weatherId: Int) -> String {
        if weatherId < 800 {
            return Constants.AppPalette.rainyPageBackgroundGrey
        }
        else if weatherId == 800 {
            return Constants.AppPalette.sunnyPageBackgroundGreen
        }
        else if weatherId >= 801  {
            return Constants.AppPalette.cloudyPageBackgroundGrey
        }
        else {
            return Constants.AppPalette.sunnyPageBackgroundGreen
        }
    }
    
    func getHeaderBackgroundImageName(weatherId: Int) -> String {
        if weatherId < 800 {
            return Constants.CurrentWeatherBackgroundImageNames.forestRainy
        }
        else if weatherId == 800 {
            return Constants.CurrentWeatherBackgroundImageNames.forestSunny
        }
        else if weatherId >= 801  {
            return Constants.CurrentWeatherBackgroundImageNames.forestCloudy
        }
        else {
            return Constants.CurrentWeatherBackgroundImageNames.forestSunny
        }
    }
    
    func getHomeHeaderHeight(viewWidth: Double) -> Double {
        //Header background images have the dimensions 360 × 321. We may need to update..
        //...the constant in the formula below if the dimensions of the images are changed..
        var height = viewWidth * (321 / 360)
        height = height + 80 //offset
        return height
    }

}
