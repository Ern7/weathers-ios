//
//  CurrentWeatherUseCaseTests.swift
//  WeatherTests
//
//  Created by Ernest Nyumbu on 2022/04/10.
//

@testable import Weather
import XCTest
import Combine

class CurrentWeatherUseCaseTests : XCTestCase {
    
    var sut : CurrentWeatherUseCaseImp!
    var latitude: Double!
    var longitude: Double!
    var measurementUnit: MeasurementUnit!
    var rainWeatherId : Int!
    var clearWeatherId : Int!
    var partlySunnyWeatherId : Int!
    var observers: [AnyCancellable]!
    
    override func setUp() {
        super.setUp()
        sut = CurrentWeatherUseCaseImp.shared
        latitude = -25.9992
        longitude = 28.1263
        measurementUnit = MeasurementUnit.metric
        rainWeatherId = 799
        clearWeatherId = 800
        partlySunnyWeatherId = 802
        observers = []
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        latitude = nil
        longitude = nil
        measurementUnit = nil
        rainWeatherId = nil
        clearWeatherId = nil
        partlySunnyWeatherId = nil
        observers = nil
    }
    
    func testShouldFetchCurrentWeather(){
        let expectation = self.expectation(description: "fetch current weather")
    
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
                XCTAssertNotNil(value.id)
            }).store(in: &observers)
        
        self.waitForExpectations(timeout: 6.0, handler: nil)
    }
    
    func testShouldGetPageBackgroundColorHex(){
        let rainBackgroundColor = sut.getPageBackgroundColorHex(weatherId: rainWeatherId)
        XCTAssertEqual(rainBackgroundColor, Constants.AppPalette.rainyPageBackgroundGrey)
        
        let clearBackgroundColor = sut.getPageBackgroundColorHex(weatherId: clearWeatherId)
        XCTAssertEqual(clearBackgroundColor, Constants.AppPalette.sunnyPageBackgroundGreen)
        
        let partlySunnyBackgroundColor = sut.getPageBackgroundColorHex(weatherId: partlySunnyWeatherId)
        XCTAssertEqual(partlySunnyBackgroundColor, Constants.AppPalette.cloudyPageBackgroundGrey)
    }
    
    func testShouldGetHeaderBackgroundImageName(){
        let rainBackgroundImage = sut.getHeaderBackgroundImageName(weatherId: rainWeatherId)
        XCTAssertEqual(rainBackgroundImage, Constants.CurrentWeatherBackgroundImageNames.forestRainy)
        
        let clearBackgroundImage = sut.getHeaderBackgroundImageName(weatherId: clearWeatherId)
        XCTAssertEqual(clearBackgroundImage, Constants.CurrentWeatherBackgroundImageNames.forestSunny)
        
        let partlySunnybackgroundImage = sut.getHeaderBackgroundImageName(weatherId: partlySunnyWeatherId)
        XCTAssertEqual(partlySunnybackgroundImage, Constants.CurrentWeatherBackgroundImageNames.forestCloudy)
    }
}

