//
//  Coordinator.swift
//  OCRMobile
//
//  Created by Kenan Baylan on 11.05.2023.


import Foundation
import UIKit


class ImageToPdfCoordinator : Coordinator {
    
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    func start() {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(ImagetoTextScannerViewController.self)")
        navigationController.show(controller, sender: nil)
    }
    
    
    func presentAlert(_ alertController: UIAlertController, animated: Bool, completion: (() -> Void)?) {
        navigationController.present(alertController, animated: animated, completion: completion)
    }
    
    
}

