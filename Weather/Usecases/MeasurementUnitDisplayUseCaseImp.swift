//
//  MeasurementUnitDisplayUseCaseImp.swift
//  Weather
//
//  Created by Ernest Nyumbu on 2022/04/05.
//

import Foundation

final class MeasurementUnitDisplayUseCaseImp {
    
    static let shared = MeasurementUnitDisplayUseCaseImp()
    
}

extension MeasurementUnitDisplayUseCaseImp: MeasurementUnitDisplayUseCase {
    
    func getTemperatureUnitDisplayText(measurementUnit: MeasurementUnit) -> String {
        if measurementUnit == MeasurementUnit.standard {
            return "K" //Kelvin
        }
        else if measurementUnit == MeasurementUnit.metric {
            return "°C" //Degrees Celcius
        }
        else if measurementUnit == MeasurementUnit.imperial {
            return "°F" //Degrees Fahrenheit
        }
        else {
            return ""
        }
    }

    
}

