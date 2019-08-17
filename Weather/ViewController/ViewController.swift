//
//  ViewController.swift
//  Weather
//
//  Created by Riccardo on 17/08/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getWeatherReport()
        
    }
    
    func getWeatherReport() {
        
        DataProvider.getWeatherReport { (weatherReport, error) in
            
            if let error = error {
                print(error)
            } else {
                print(weatherReport!.conditions!)
            }
        }
        
        
        
    }

}

