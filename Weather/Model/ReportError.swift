//
//  Errors.swift
//  Weather
//
//  Created by Riccardo on 17/08/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation

enum ReportError: Error {
    
    case connectionError
    case notCachedDataError
    case networkError(_ error: Error?)
    case parsingError(_ error: Error?)
    case cachingError(_ error: Error?)
    case locationAuthorizationError
    case locationFail(_ error: Error?)
    case unknownError
}

extension ReportError {
    
    var title: String {
        return "Ooops"
    }
    
    var userDescription: String {
        
        switch self {
            
        case .connectionError:
            return "Please connect to the internet to refresh data"
        case .notCachedDataError:
            return "You seem to be offline and there is not recent data previously saved available. Please make sure you are connected to the internet and try again"
        case .networkError(let error):
            return "There was a problem downloading the data from the internet. \(error?.localizedDescription ?? ""))"
        case .parsingError(let error):
            return "There was a problem processing the data downloaded from the internet \(error?.localizedDescription ?? "")"
        case .cachingError(let error):
            return "There was a problem saving the data in the device \(error?.localizedDescription ?? "")"
        case .locationAuthorizationError:
            return "Access to your location was denied. Please change authorization in Settings"
        case .locationFail(let error):
            return "There was a problem retriving your location. \(error?.localizedDescription ?? "")"
        case .unknownError:
            return "There was an unknown error updating the report"
        }
    }
}
