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
    
    func convertToForecastDayList(timeStampDataList: [TimeStampData]) -> [ForecastDay] {
        
        let dateFormatter = DateFormatter()
        var datesList = [String]()
        var forecastDaysList = [ForecastDay]()
        
        let dateNow = Date.now
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateNowOnlyText = dateFormatter.string(from: dateNow)
        
        for timeStampData in timeStampDataList {
            
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let date = dateFormatter.date(from:timeStampData.dtTxt)
            
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateOnlyText = dateFormatter.string(from: date!)
            
            if !datesList.contains(dateOnlyText) && dateNowOnlyText != dateOnlyText {
                datesList.append(dateOnlyText)
                DebuggingLogger.printData("DateOnlyText \(dateOnlyText)")
            }
        }
        
        for dateText in datesList {
            let dailyTimeStamps = timeStampDataList.filter {
                $0.dtTxt.contains(dateText)
            }
            
            var sum:Double = 0.0
            var weatherId: Int = 0
            for timeStamp in dailyTimeStamps {
                if let temp = timeStamp.main.temp {
                    sum = sum + temp
                }
            }
            
            if (dailyTimeStamps.count > 0 && dailyTimeStamps[0].weather.count > 0){
                weatherId = dailyTimeStamps[0].weather[0].id
            }
            
            let average_temperature = sum / Double(dailyTimeStamps.count)
            forecastDaysList.append(ForecastDay(dateText: dateText, weatherId: weatherId, temperature: average_temperature))
        }
        
        return forecastDaysList
    }

}
