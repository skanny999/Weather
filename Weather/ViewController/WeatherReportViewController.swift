//
//  ViewController.swift
//  Weather
//
//  Created by Riccardo on 17/08/2019.
//  Copyright © 2019 RiccardoScanavacca. All rights reserved.
//

import UIKit

protocol WeatherReportViewControllerDelegate: class {
    
    func viewControllerDidTapRefresh(_ viewController: UIViewController)
}

class WeatherReportViewController: UIViewController {
    
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var conditionsLabel: UILabel!
    @IBOutlet weak var temporatureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var lastUpdatedLabel: UILabel!
    
    var spinner = UIActivityIndicatorView(style: .white)
    var refreshButton: UIBarButtonItem!
    
    @IBOutlet weak var reportImageView: UIImageView!
    
    weak var delegate: WeatherReportViewControllerDelegate?
    
    var viewModel: WeatherReportViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureBar()
        viewModel = WeatherReportViewModel()
        configureViewModelUpdater()
        self.delegate = viewModel
        updateReportLabels()
        spinner.startAnimating()
    }
    
    private func configureBar() {
        
        refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshData))
        refreshButton.tintColor = .white
        let barbuttonItem = UIBarButtonItem(customView: spinner)
        navigationItem.setRightBarButton(refreshButton, animated: false)
        navigationItem.setLeftBarButton(barbuttonItem, animated: false)
    }
    
    private func configureViewModelUpdater() {
        
        viewModel.updateReport = {
            DispatchQueue.main.async { [weak self] in
                self?.updateReportLabels()
            }
        }
        
        viewModel.displayAlert = { (error) in
            DispatchQueue.main.async { [weak self] in
                self?.showAlert(for: error)
            }
        }
        
        viewModel.displaySpinner = { [weak self] (shouldSpin) in
            
            DispatchQueue.main.async {
               shouldSpin ? self?.spinner.startAnimating() : self?.spinner.stopAnimating()
            }
        }
    }

    private func updateReportLabels() {
        
        latitudeLabel.text = viewModel.latitude
        longitudeLabel.text = viewModel.longitude
        conditionsLabel.text = viewModel.conditions
        temporatureLabel.text = viewModel.temperature
        windSpeedLabel.text = viewModel.windSpeed
        windDirectionLabel.text = viewModel.windDirection
        lastUpdatedLabel.text = viewModel.lastUpdated
        reportImageView.load(url: viewModel.iconURL)
    }
    
    @objc private func refreshData() {
        
        delegate?.viewControllerDidTapRefresh(self)
    }
}

