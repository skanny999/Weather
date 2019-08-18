//
//  URLFactory.swift
//  Weather
//
//  Created by Riccardo on 17/08/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation
import CoreLocation


struct URLFactory {
    
    static func weatherUrl(for location: CLLocation) -> URL {
        
        let latitude = String(location.coordinate.latitude)
        let longitude = String(location.coordinate.longitude)
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&APPID=\(Constant.apiKey)"
        
        guard let url = URL(string: urlString) else {
            fatalError("Invalid string for url")
        }
        return url
    }
    
    static func iconUrl(for iconString: String?) -> URL? {
        
        guard let iconString = iconString else { return nil }
        
        let urlString = "http://openweathermap.org/img/w/\(iconString)"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid string for url")
        }
        return url
    }
    
}
