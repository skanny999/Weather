//
//  CardinalDirection.swift
//  Weather
//
//  Created by Riccardo on 17/08/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation

enum Cardinal {
    
    case n, nne, ne, ene, e, ese, se, sse, s, ssw, sw, wsw, w, wnw, nw, nnw
    
    var description: String {
        
        switch self {
        case .n:    return "North"
        case .nne:  return "North-NorthEast"
        case .ne:   return "NorthEast"
        case .ene:  return "East-NorthEast"
        case .e:    return "East"
        case .ese:  return "East-SouthEast"
        case .se:   return "SouthEast"
        case .sse:  return "South-SouthEast"
        case .s:    return "South"
        case .ssw:  return "South-SouthWest"
        case .sw:   return "SouthWest"
        case .wsw:  return "West-SouthWest"
        case .w:    return "West"
        case .wnw:  return "West-NorthWest"
        case .nw:   return "NorthWest"
        case .nnw:  return "North-NorthWest"
        }
    }
}
