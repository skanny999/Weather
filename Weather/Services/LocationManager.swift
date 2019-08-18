//
//  LocationManager.swift
//  Weather
//
//  Created by Riccardo on 17/08/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager: NSObject {
    
    private let locationManager = CLLocationManager()
    var updateLocation: ((CLLocation?, Error?) -> Void)?

    
    static let shared = LocationManager()
    
    private override init() {
        super.init()
        configureLocationManager()
    }
    
    private func configureLocationManager() {
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
            updateLocation?(locations.last, nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        status.rawValue == 4 ? locationManager.requestLocation() : updateLocation?(nil, ReportError.locationAuthorizationError)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        updateLocation?(nil, ReportError.locationFail(error))
    }
}
