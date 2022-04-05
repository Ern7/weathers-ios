//
//  MeasurementUnitDisplayUsecase.swift
//  Weather
//
//  Created by Ernest Nyumbu on 2022/04/05.
//

import Foundation

protocol MeasurementUnitDisplayUseCase {
    func getTemperatureUnitDisplayText(measurementUnit: MeasurementUnit) -> String 
}


