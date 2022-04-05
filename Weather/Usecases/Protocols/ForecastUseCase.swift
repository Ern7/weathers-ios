//
//  ForecastUseCase.swift
//  Weather
//
//  Created by Ernest Nyumbu on 2022/04/05.
//

import Foundation
import Combine

protocol ForecastUseCase {
    
    func get(latitude: Double, longitude: Double, measurementUnit: MeasurementUnit) -> Future<ForecastResponse, APICallError>
    
    func convertToForecastDayList(timeStampDataList: [TimeStampData]) -> [ForecastDay]
}
