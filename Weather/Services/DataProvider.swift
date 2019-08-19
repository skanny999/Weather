//
//  DataProvider.swift
//  Weather
//
//  Created by Riccardo on 17/08/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation
import CoreLocation
import Network


class DataProvider {
    
    static let shared = DataProvider()
    
    private let locationManager: LocationManager
    private let monitor = NWPathMonitor()
    private var isConnected = false
    
    var weatherReportUpdater: ((WeatherReport?, ReportError?) -> Void)?
    
    init() {
        
        locationManager = LocationManager.shared
        locationManager.delegate = self
        configureMonitor()
    }
    
    private func configureMonitor() {
        
        monitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
        }
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
    
    func getWeatherReport(isRefreshing: Bool) {
        
        guard isConnected else {
            
            isRefreshing ? weatherReportUpdater?(nil, ReportError.connectionError) : completeWithPreviousReport()
            return
        }
        
        if let location = LocationManager.shared.currentLocation {
            
            fetchWeatherReportData(for: location)
            
        } else {
            
            LocationManager.shared.requestUpdateLocation()
        }
    }
}


private extension DataProvider {
    
    private func fetchWeatherReportData(for location: CLLocation) {
        
        NetworkProvider.getWeatherReport(for: location, completion: { [weak self] (data, error) in
            
            if let error = error {
                
                self?.weatherReportUpdater?(nil, ReportError.networkError(error))
                
            } else {
                
                self?.weatherReport(from: data)
            }
        })
    }
    
    private func completeWithPreviousReport() {
        
        if let weatherReport = StorageCache.retrieveModel(), weatherReport.isStillValid {
            weatherReportUpdater?(weatherReport, nil)
        } else {
            weatherReportUpdater?(nil, ReportError.notCachedDataError)
        }
    }
    
    // Data processor
    
    func weatherReport(from data: Data?) {
        
        guard let data = data else {
            weatherReportUpdater?(nil, ReportError.networkError(nil))
            return
        }
        
        do {
            var weatherReport = try JSONDecoder().decode(WeatherReport.self, from: data)
            weatherReport.lastUpdated = Date()
            weatherReportUpdater?(weatherReport, nil)
            StorageCache.saveModel(weatherReport)
            
        } catch {
            
            weatherReportUpdater?(nil, ReportError.parsingError(error))
        }
    }
}


extension DataProvider: LocationDelegate {
    
    func locationDidUpdate(with location: CLLocation?, _ error: Error?) {
        
        location == nil ? weatherReportUpdater?(nil, ReportError.locationFail(error)) : getWeatherReport(isRefreshing: false)
    }
}
