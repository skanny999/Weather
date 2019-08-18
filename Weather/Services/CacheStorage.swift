//
//  CacheStorage.swift
//  Weather
//
//  Created by Riccardo on 17/08/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation

class CacheStorage {
    
    static func saveReport(_ report: WeatherReport) {
        
        store(report, as: "WeatherReport")
    }
    
    static func retrieveReport() -> WeatherReport? {
        
        return retrieve("WeatherReport", as: WeatherReport.self)
    }
}


private extension CacheStorage {
    
    static func store<T: Encodable>(_ object: T, as fileName: String) {
        
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            //throw error
            return
        }
        
        do {
            let data = try JSONEncoder().encode(object)
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        } catch {
            //throw error
            fatalError(error.localizedDescription)
        }
    }
    
    
    static func retrieve<T: Decodable>(_ fileName: String, as type: T.Type) -> T? {
        
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first,
            let data = FileManager.default.contents(atPath: url.path) else { return nil }
        
        do {
            let model = try JSONDecoder().decode(type, from: data)
            return model
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
}
