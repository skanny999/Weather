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

        return self < Date(timeIntervalSinceNow: -86400)
    }
}
