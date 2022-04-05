//
//  SettingsUseCase.swift
//  Weather
//
//  Created by Ernest Nyumbu on 2022/04/05.
//

import Foundation

protocol MeasurementUnitSettingsUseCase {
    func set(measurementUnit : MeasurementUnit)
    func get() -> MeasurementUnit
}
