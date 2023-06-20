//
//  HomeCoordinator.swift
//  OCRMobile
//
//  Created by Kenan Baylan on 26.05.2023.
//

import Foundation

import UIKit
import PanModal

class HomeCoordinator : Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    func start() {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(ImagetoTextScannerViewController.self)")
        navigationController.show(controller, sender: nil)
    }
    
    func showImageToPdfPage() {
        let controller = ImageToPdfViewController.instantiate(name: .main)
        navigationController.pushViewController(controller, animated: true)
    }
    
    
}
