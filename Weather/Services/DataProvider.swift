//
//  DataProvider.swift
//  Weather
//
//  Created by Riccardo on 17/08/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation

class DataProvider {
    
    static func getWeatherReport(completion:@escaping (WeatherReport?, Error?) -> Void) {
        
        //get current location
        
        LocationManager.shared.updateLocation = { (location, error) in
            
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let location = location else {
                completion(nil, ReportError.locationFail(nil))
                return
            }
            
            // make request with the coordinates
            
            NetworkProvider.getWeatherReport(for: location, completion: { (data, error) in
                
                if let error = error {
                    
                    // Deal with network error
                    
                    reportCompletion(with: error, completion: completion)
                    
                } else {
                    
                    // Process Data
                    
                    weatherReport(from: data, completion: completion)
                }
            })
        }
    }
}

extension DataProvider {
    
    static func reportCompletion(with error: Error, completion: @escaping (WeatherReport?, Error?) -> Void) {
        
        guard case ReportError.connectionError = error else {
            completion(nil, error)
            return
        }
        
        if let weatherReport = CacheStorage.retrieveReport(), weatherReport.isStillValid {
            completion(weatherReport, nil)
        } else {
            completion(nil, ReportError.notCachedDataError)
        }
    }

    
    static func weatherReport(from data: Data?, completion: @escaping (WeatherReport?, Error?) -> Void) {
        
        guard let data = data else {
            completion(nil, ReportError.networkError(nil))
            return
        }
        
        do {
            let weatherReport = try JSONDecoder().decode(WeatherReport.self, from: data)
            completion(weatherReport, nil)
            CacheStorage.saveReport(weatherReport)
            
        } catch {
            
            completion(nil, ReportError.parsingError(error))
        }
    }
    
}
