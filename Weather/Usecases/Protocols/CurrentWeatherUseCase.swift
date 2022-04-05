//
//  CurrentWeatherUseCase.swift
//  Weather
//
//  Created by Ernest Nyumbu on 2022/04/05.
//

import Foundation
import Combine

protocol CurrentWeatherUseCase {
    func get(latitude: Double, longitude: Double, measurementUnit: MeasurementUnit) -> Future<CurrentWeather, APICallError>
}
