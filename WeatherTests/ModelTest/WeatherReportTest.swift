//
//  WeatherReportTest.swift
//  WeatherTests
//
//  Created by Riccardo on 17/08/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import XCTest
@testable import Weather

class WeatherReportTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testWeatherReportModel() {
        
        let data = FileExtractor.extractJsonFile(withName: "weather", forClass: type(of: self))
        
        let weather = try! JSONDecoder().decode(WeatherReport.self, from: data)
        
        XCTAssertNotNil(weather)
        XCTAssert(weather.temperature == 34.95)
        XCTAssert(weather.windSpeed == 6.7)
        XCTAssert(weather.windDirection == "West")
        XCTAssert(weather.conditions == "Clouds")
        XCTAssert(weather.latitude == 51.51)
        XCTAssert(weather.longitude == -0.13)
    }

}
