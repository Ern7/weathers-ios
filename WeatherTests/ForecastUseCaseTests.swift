//
//  ForecastUseCaseTests.swift
//  WeatherTests
//
//  Created by Ernest Nyumbu on 2022/04/10.
//

@testable import Weather
import XCTest
import Combine

class ForecastUseCaseTests : XCTestCase {
    
    var sut : ForecastUseCaseImp!
    var latitude: Double!
    var longitude: Double!
    var measurementUnit: MeasurementUnit!
    var observers: [AnyCancellable]!
    
    override func setUp() {
        super.setUp()
        sut = ForecastUseCaseImp.shared
        latitude = -25.9992
        longitude = 28.1263
        measurementUnit = MeasurementUnit.metric
        observers = []
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        latitude = nil
        longitude = nil
        measurementUnit = nil
        observers = nil
    }
    
    func testShouldFetchForecast(){
        let expectation = self.expectation(description: "fetch forecast")
    
        sut.get(latitude: latitude, longitude: longitude, measurementUnit: measurementUnit)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure(let error):
                    XCTAssertNotNil(error)
                }
            }, receiveValue: { value in
                XCTAssertNotNil(value)
                let forecastDaysList = self.sut.convertToForecastDayList(timeStampDataList: value.list)
                XCTAssertNotNil(forecastDaysList)
                XCTAssert(forecastDaysList.count > 0)
            }).store(in: &observers)
        
        self.waitForExpectations(timeout: 6.0, handler: nil)
    }
    
}


