//
//  WeatherReport.swift
//  Weather
//
//  Created by Riccardo on 17/08/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation

struct WeatherReport: Codable {
    
    private let coord: Coordinates?
    private let wind: Wind?
    private let main: Main?
    private let weather: [Weather]?
    
    let lastUpdated = Date()
    
    var conditions: String? {
        return weather?.first?.main
    }
    
    var iconString: String? {
        
        return weather?.first?.icon
    }
    
    var temperature: Double? {
        return main?.temp
    }
    
    var windSpeed: Double? {
        return wind?.speed
    }
    
    var windDirection: String? {
        return wind?.deg?.cardinalDirection
    }
    
    var latitude: Double? {
        return coord?.lat
    }
    
    var longitude: Double? {
        return coord?.lon
    }
    
    var isStillValid: Bool {
        
        return lastUpdated.isLessThan24HoursAgo
    }
}


private struct Weather: Codable {
    
    let main: String?
    let icon: String?
}

private struct Coordinates: Codable {
    
    let lon: Double?
    let lat: Double?
}

private struct Wind: Codable {
    
    let speed: Double?
    let deg: Int?
}


private struct Main: Codable {
    
    let temp: Double?
}
