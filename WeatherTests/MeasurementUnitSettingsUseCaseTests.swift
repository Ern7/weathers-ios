//
//  MeasurementUnitSettingsUseCaseTests.swift
//  WeatherTests
//
//  Created by Ernest Nyumbu on 2022/04/10.
//

@testable import Weather
import XCTest

class MeasurementUnitSettingsUseCaseTests : XCTestCase {
    
    var sut : MeasurementUnitSettingsUseCaseImp!
    var imperialMeasurementUnit: MeasurementUnit!

    
    override func setUp() {
        super.setUp()
        sut = MeasurementUnitSettingsUseCaseImp.shared
        imperialMeasurementUnit = MeasurementUnit.imperial
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        imperialMeasurementUnit = nil
        
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: Constants.UserDefaultsKeys.MeasurementUnit)
    }
    
    
    func testShouldGetStoredMeasurementUnit(){
        let result = self.sut.get()
        XCTAssertNotNil(result)
    }
    
    func testShouldSaveMeasurementUnit(){
        self.sut.set(measurementUnit: imperialMeasurementUnit)
        
        let userDefaults = UserDefaults.standard
        if let value = userDefaults.value(forKey: Constants.UserDefaultsKeys.MeasurementUnit) as? String {
            let unit = MeasurementUnit(rawValue: value)!
            XCTAssertEqual(imperialMeasurementUnit, unit)
        }
        
    }
    
}

