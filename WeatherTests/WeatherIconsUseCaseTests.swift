//
//  WeatherIconsUseCaseTests.swift
//  WeatherTests
//
//  Created by Ernest Nyumbu on 2022/04/10.
//


@testable import Weather
import XCTest

class WeatherIconsUseCaseTests : XCTestCase {
    
    var sut : WeatherIconsUseCaseImp!
    var rainWeatherId : Int!
    var clearWeatherId : Int!
    var partlySunnyWeatherId : Int!
    
    override func setUp() {
        super.setUp()
        sut = WeatherIconsUseCaseImp.shared
        rainWeatherId = 799
        clearWeatherId = 800
        partlySunnyWeatherId = 802
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        rainWeatherId = nil
        clearWeatherId = nil
        partlySunnyWeatherId = nil
    }
    
    func testShouldGetRainIconName(){
        let weatherIconName = sut.getWeatherIconName(weatherId: rainWeatherId)
        XCTAssertEqual(weatherIconName, "rain")
    }
    
    func testShouldGetClearIconName(){
        let weatherIconName = sut.getWeatherIconName(weatherId: clearWeatherId)
        XCTAssertEqual(weatherIconName, "clear")
    }
    
    func testShouldGetSunnyIconName(){
        let weatherIconName = sut.getWeatherIconName(weatherId: partlySunnyWeatherId)
        XCTAssertEqual(weatherIconName, "partlysunny")
    }
    
}

