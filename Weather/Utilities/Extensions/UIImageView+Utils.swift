//
//  UIImageView+Utils.swift
//  Weather
//
//  Created by Riccardo on 18/08/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func load(url: URL?) {
        
        guard let url = url else {
            self.image = nil
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
