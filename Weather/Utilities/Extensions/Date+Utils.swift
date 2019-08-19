//
//  Date+Utils.swift
//  Weather
//
//  Created by Riccardo on 17/08/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation

extension Date {
    
    var isLessThan24HoursAgo: Bool {

        return self > Date(timeIntervalSinceNow: -86400)
    }
    
    var longDescription: String {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        
        return formatter.string(from: self)
    }
}
