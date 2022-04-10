//
//  MeasurementUnitDisplayUseCaseTests.swift
//  WeatherTests
//
//  Created by Ernest Nyumbu on 2022/04/10.
//

import Foundation


@testable import Weather
import XCTest
import Combine

class MeasurementUnitDisplayUseCaseTests : XCTestCase {
    
    var sut : MeasurementUnitDisplayUseCaseImp!
    var standardMeasurementUnit: MeasurementUnit!
    var metricMeasurementUnit: MeasurementUnit!
    var imperialMeasurementUnit: MeasurementUnit!

    
    override func setUp() {
        super.setUp()
        sut = MeasurementUnitDisplayUseCaseImp.shared
        standardMeasurementUnit = MeasurementUnit.standard
        metricMeasurementUnit = MeasurementUnit.metric
        imperialMeasurementUnit = MeasurementUnit.imperial
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        standardMeasurementUnit = nil
        metricMeasurementUnit = nil
        imperialMeasurementUnit = nil
    }
    
    
    func testShouldGetStandardUnitDisplayText(){
        let result = self.sut.getTemperatureUnitDisplayText(measurementUnit: standardMeasurementUnit)
        XCTAssertEqual(result, "K")
    }
    
    func testShouldGetMetricUnitDisplayText(){
        let result = self.sut.getTemperatureUnitDisplayText(measurementUnit: metricMeasurementUnit)
        XCTAssertEqual(result, "°C")
    }
    
    func testShouldGetImperialUnitDisplayText(){
        let result = self.sut.getTemperatureUnitDisplayText(measurementUnit: imperialMeasurementUnit)
        XCTAssertEqual(result, "°F")
    }
}

