//
//  NetworkProvider.swift
//  Weather
//
//  Created by Riccardo on 17/08/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation
import CoreLocation
import Network

class NetworkProvider {
    
    static func getWeatherReport(for location: CLLocation, completion: @escaping (Data?, Error?) -> Void) {
        
        let url = URLFactory.weatherUrl(for: location)
        getData(fromUrl: url, completion: completion)

    }
}

private extension NetworkProvider {
    
    static func getData(session: URLSession = URLSession.shared, fromUrl url: URL, completion: @escaping (Data?, Error?) -> Void) {
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            if let error = error as NSError? {
                
                if error.code == NSURLErrorNotConnectedToInternet {
                    completion(nil, ReportError.connectionError)
                } else {
                    completion(nil, ReportError.networkError(error))
                }
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                
                let error = NSError(domain: "", code: 404, userInfo: nil)
                completion(nil, error)
                return
            }
            
            if 200..<300 ~= response.statusCode {
                
                completion(data, nil)
                
            } else {
                
                let error = NSError(domain:"", code:response.statusCode, userInfo:nil)
                completion(nil, ReportError.networkError(error))
            }
        }
        
        task.resume()
    }

}
