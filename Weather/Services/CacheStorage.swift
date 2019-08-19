//
//  CacheStorage.swift
//  Weather
//
//  Created by Riccardo on 17/08/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation

public class StorageCache {
    
    static func saveModel(_ model: WeatherReport) {
        
        store(model, as: "Model")
    }
    
    static func retrieveModel() -> WeatherReport? {
        
        return retrieve("Model", as: WeatherReport.self)
    }
}


private extension StorageCache {
    
    static func store<T: Encodable>(_ object: T, as fileName: String) {
        
        
        do {
            let data = try JSONEncoder().encode(object)
            UserDefaults.standard.set(data, forKey: "Model")
        } catch {
            fatalError(error.localizedDescription)
        }
        
        
        /// preferred system, but it was buggy
        
        
        //        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
        //            //throw error
        //            return
        //        }
        //
        //        do {
        //            let data = try JSONEncoder().encode(object)
        //            if FileManager.default.fileExists(atPath: url.path) {
        //                try? FileManager.default.removeItem(at: url)
        //            }
        //            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        //        } catch {
        //            //throw error
        //            fatalError(error.localizedDescription)
        //        }
        
    }
    
    
    static func retrieve<T: Decodable>(_ fileName: String, as type: T.Type) -> T? {
        
        if let data = UserDefaults.standard.data(forKey: "Model") {
            
            do {
                let model = try JSONDecoder().decode(type, from: data)
                return model
            } catch {
                print(error.localizedDescription)
                return nil
            }
        }
        return nil
        
        
        //        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first,
        //            let data = FileManager.default.contents(atPath: url.path) else { return nil }
        //
        //        do {
        //            let model = try JSONDecoder().decode(type, from: data)
        //            return model
        //        } catch {
        //            print(error.localizedDescription)
        //            return nil
        //        }
        //    }
    }
    
}
