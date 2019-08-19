//
//  URLTest.swift
//  WeatherTests
//
//  Created by Riccardo Scanavacca on 19/08/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import XCTest
import CoreLocation
@testable import Weather

class URLTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWeatherUrl() {
        
        let location = CLLocation(latitude: 10.12, longitude: 20.23)
        
        let url = URLFactory.weatherUrl(for: location)
        let urlString =  "https://api.openweathermap.org/data/2.5/weather?lat=10.12&lon=20.23&units=metric&APPID=fe257ae147b41b18ac34d6b092e38c92"
        
        XCTAssert(url == URL(string:urlString), url.absoluteString)
        
        
    }

}
