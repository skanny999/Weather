//
//  UIViewController+Utils.swift
//  Weather
//
//  Created by Riccardo on 18/08/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    
    func showAlert(for error: ReportError) {
        
        let alert = alertController(for: error)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    private func alertController(for error: ReportError) -> UIAlertController {
        
        let alertController = UIAlertController(title: error.title, message: error.userDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        
        return alertController
    }
    
}
