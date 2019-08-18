//
//  WeatherReportViewModel.swift
//  Weather
//
//  Created by Riccardo on 17/08/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation

class WeatherReportViewModel {
    
    private var weatherReport: WeatherReport? {
        didSet {
            if let weather = weatherReport {
                
                //update viewController
            }
        }
    }
    
    init() {
        
        DataProvider.getWeatherReport { (weatherReport, error) in
            
            if let error = error {
                
                print(error)
                return
            }
            
            if let weatherReport = weatherReport {
                
                self.weatherReport = weatherReport
                
            } else {
                
                // show error
            }
        }
    }
    
    //testing
    
    init(with weatherReport: WeatherReport) {
        self.weatherReport = weatherReport
    }
    
    var conditions: String {
        return weatherReport?.conditions ?? "N/A"
    }
    
    var iconURL: URL? {
        
        return URLFactory.iconUrl(for: weatherReport?.iconString)
    }
    
    var temperature: String {
        
        guard let temp = weatherReport?.temperature else { return "N/A" }
        return "\(Int(temp))°C"
    }
    
    var windSpeed: String? {
        
        guard let speed = weatherReport?.windSpeed else { return "N/A" }
        return "\(Int(speed))mph"
    }
    
    var windDirection: String? {
        
        return weatherReport?.windDirection
    }
    
    
}
