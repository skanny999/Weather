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
        
        let manager = LocationManager.shared
        
        manager.updateLocation = { (location, error) in
            
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
                    completion(nil, error)
                    return
                }
                
                guard let data = data else {
                    completion(nil, ReportError.networkError(nil))
                    return
                }
                
                // parse the results
                
                do {
                    
                    let weatherReport = try JSONDecoder().decode(WeatherReport.self, from: data)
                    completion(weatherReport, nil)
                    
                } catch {
                    
                    completion(nil, ReportError.parsingError(error))
                }
            })
        }
    }
}
