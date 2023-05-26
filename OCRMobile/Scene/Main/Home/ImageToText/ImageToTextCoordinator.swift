//
//  Coordinator.swift
//  OCRMobile
//
//  Created by Kenan Baylan on 11.05.2023.


import Foundation
import UIKit


class ImageToTextCoordinator : Coordinator {
    
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    var languageSelection: ((Languages)->())?
    
    
    func start() {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(ImagetoTextScannerViewController.self)")
        navigationController.show(controller, sender: nil)
    }
    
    
    func presentAlert(_ alertController: UIAlertController, animated: Bool, completion: (() -> Void)?) {
        navigationController.present(alertController, animated: animated, completion: completion)
    }
    
    
    func showLanguageModal() {
        let controller = LanguageViewController.instantiate(name: .main)
        controller.selectionCallback = { [weak self] language in
            self?.languageSelection?(language)
        }
        navigationController.presentPanModal(controller)
    }
    
    func showHistoryPage() {
        let controller = HistoryViewController.instantiate(name: .main)
        navigationController.show(controller, sender: nil)
    }
    
    
}

