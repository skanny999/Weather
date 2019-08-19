//
//  WeatherReportViewModel.swift
//  Weather
//
//  Created by Riccardo on 17/08/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation
import UIKit

class WeatherReportViewModel {
    
    private var weatherReport: WeatherReport?
    
    init() {
        
        configureDataUpdater()
        DataProvider.shared.getWeatherReport(isRefreshing: false)
        displaySpinner?(true)
    }
    
    
    private func configureDataUpdater() {
        
        DataProvider.shared.weatherReportUpdater = { [weak self] (weatherReport, error) in
            
            self?.displaySpinner?(false)
            
            if let error = error {
                self?.displayAlert?(error)
                return
            }
            
            guard let weatherReport = weatherReport else {
                self?.displayAlert?(ReportError.unknownError)
                return
            }
            
            self?.weatherReport = weatherReport
            self?.updateReport?()
        }
        
    }
    
    //test initializer
    
    init(with weatherReport: WeatherReport) {
        self.weatherReport = weatherReport
    }
    
    
    // View Updater
    
    var updateReport: (() -> Void)?
    var displayAlert: ((ReportError) -> Void)?
    var displaySpinner: ((Bool) -> Void)?
    
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
    
    var windSpeed: String {
        
        guard let speed = weatherReport?.windSpeed else { return "N/A" }
        return "\(Int(speed))mph"
    }
    
    var windDirection: String? {
        
        return weatherReport?.windDirection ?? "N/A"
    }
    
    var latitude: String {
        
        if let latitude = weatherReport?.latitude {
            return "Latitude: \(String(latitude))"
        } else {
            return "Latitude: N/A"
        }
    }
    
    var longitude: String {
        
        if let longitude = weatherReport?.longitude {
            return "Longitude: \(String(longitude))"
        } else {
            return "Longitude: N/A"
        }
    }
    
    var lastUpdated: String {
        if let lastUpdatedDate = weatherReport?.lastUpdated {
            return "Last updated: \(lastUpdatedDate.longDescription)"
        }
        return ""
    }
}

// ViewController Delegate

extension WeatherReportViewModel: WeatherReportViewControllerDelegate {
    
    func viewControllerDidTapRefresh(_ viewController: UIViewController) {
        
        displaySpinner?(true)
        DataProvider.shared.getWeatherReport(isRefreshing: true)
    }
}
