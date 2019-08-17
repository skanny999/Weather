//
//  CacheStorage.swift
//  Weather
//
//  Created by Riccardo on 17/08/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation

class CacheStorage {
    
    static func saveModel<T: Codable>(_ model: T) {
        
        store(model, as: "Model")
    }
    
    static func retrieveModel<T: Codable>() -> T? {
        
        return retrieve("Model", as: T.self)
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
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
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
