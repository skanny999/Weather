//
//  ReportViewModelTest.swift
//  WeatherTests
//
//  Created by Riccardo on 18/08/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import XCTest
@testable import Weather

class ReportViewModelTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testViewModel() {
        
        let data = FileExtractor.extractJsonFile(withName: "weather", forClass: type(of: self))
        let weather = try! JSONDecoder().decode(WeatherReport.self, from: data)
        
        let weatherReport = WeatherReportViewModel(with: weather)
        
        XCTAssert(weatherReport.temperature == "34°C")
        XCTAssert(weatherReport.windSpeed == "6mph")
        XCTAssert(weatherReport.windDirection == "West")
        XCTAssert(weatherReport.conditions == "Clouds")
    }

}
