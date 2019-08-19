//
//  CacheStorageTest.swift
//  WeatherTests
//
//  Created by Riccardo Scanavacca on 19/08/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import XCTest
@testable import Weather

class CacheStorageTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testSaveRetrieveWeatherObject() {
        
        let data = FileExtractor.extractJsonFile(withName: "weather", forClass: type(of: self))
        var weather = try! JSONDecoder().decode(WeatherReport.self, from: data)
        weather.lastUpdated = Date()
        
        StorageCache.saveModel(weather)
        
        let retrievedWeather = StorageCache.retrieveModel()
        
        XCTAssert(weather.conditions == retrievedWeather?.conditions)
        XCTAssert(weather.iconString == retrievedWeather?.iconString)
        XCTAssert(weather.temperature == retrievedWeather?.temperature)
        XCTAssert(weather.windSpeed == retrievedWeather?.windSpeed)
        XCTAssert(weather.windDirection == retrievedWeather?.windDirection)
        XCTAssert(weather.latitude == retrievedWeather?.latitude)
        XCTAssert(weather.longitude == retrievedWeather?.longitude)
        
        
    }

}
