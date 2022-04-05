//
//  SettingsUseCaseImp.swift
//  Weather
//
//  Created by Ernest Nyumbu on 2022/04/05.
//

import Foundation

final class MeasurementUnitSettingsUseCaseImp {
    
    static let shared = MeasurementUnitSettingsUseCaseImp()
    private let userDefaults = UserDefaults.standard
    private var defaultMeasurementUnit: MeasurementUnit = MeasurementUnit.metric //default
    
}

extension MeasurementUnitSettingsUseCaseImp: MeasurementUnitSettingsUseCase {
    
    func get() -> MeasurementUnit {
        if let value = userDefaults.value(forKey: Constants.UserDefaultsKeys.MeasurementUnit) as? String {
            let unit = MeasurementUnit(rawValue: value)!
            return unit
        }
        
        return defaultMeasurementUnit
    }
    
    func set(measurementUnit : MeasurementUnit){
        userDefaults.set(measurementUnit.rawValue, forKey: Constants.UserDefaultsKeys.MeasurementUnit)
    }
    
}
