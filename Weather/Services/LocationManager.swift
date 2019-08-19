//
//  LocationManager.swift
//  Weather
//
//  Created by Riccardo on 17/08/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationDelegate: class {
    
    func locationDidUpdate(with location: CLLocation?, _ error: Error?)
}

class LocationManager: NSObject {
    
    static let shared = LocationManager()
    var currentLocation: CLLocation?
    weak var delegate: LocationDelegate?

    private let locationManager = CLLocationManager()
    
    private override init() {
        super.init()
        configureLocationManager()
    }
    
    func requestUpdateLocation() {
        
        locationManager.requestLocation()
    }
    
    private func configureLocationManager() {
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.requestLocation()
        case .restricted, .denied:
            break
        @unknown default:
            fatalError()
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        delegate?.locationDidUpdate(with: locations.first, nil)
        currentLocation = locations.first
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        delegate?.locationDidUpdate(with: nil, ReportError.locationFail(error))
    }
}
