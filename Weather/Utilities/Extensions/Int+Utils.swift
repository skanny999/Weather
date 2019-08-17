//
//  Int+Utils.swift
//  Weather
//
//  Created by Riccardo on 17/08/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation

extension Int {
    
    var cardinalDirection: String? {
        
        let degrees = Double(self)
        var direction: Cardinal?
        
        switch true {
        case degrees > 348.75 || degrees < 11.25:
            direction = .n
        case (11.26...33.75).contains(degrees):
            direction = .nne
        case (33.76...56.25).contains(degrees):
            direction = .ne
        case (56.26...78.75).contains(degrees):
            direction = .ene
        case (78.76...101.25).contains(degrees):
            direction = .e
        case (101.26...123.75).contains(degrees):
            direction = .ese
        case (123.76...146.25).contains(degrees):
            direction = .se
        case (146.26...168.75).contains(degrees):
            direction = .sse
        case (168.76...191.25).contains(degrees):
            direction = .s
        case (191.26...213.75).contains(degrees):
            direction = .ssw
        case (213.76...236.25).contains(degrees):
            direction = .sw
        case (236.26...258.75).contains(degrees):
            direction = .wsw
        case (258.76...281.25).contains(degrees):
            direction = .w
        case (281.26...303.75).contains(degrees):
            direction = .wnw
        case (303.76...326.25).contains(degrees):
            direction = .nw
        case (326.26...348.75).contains(degrees):
            direction = .nnw
        default:
            direction = nil
        }
        return direction?.description
    }
}
