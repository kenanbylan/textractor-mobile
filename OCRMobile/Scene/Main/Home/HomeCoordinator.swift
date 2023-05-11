//
//  Coordinator.swift
//  OCRMobile
//
//  Created by Kenan Baylan on 11.05.2023.
//

import Foundation
import UIKit


class HomeCoordinator : Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(HomeViewController.self)")
        navigationController.show(controller, sender: nil)
    }
    
    
    func presentAlert(_ alertController: UIAlertController, animated: Bool, completion: (() -> Void)?) {
        navigationController.present(alertController, animated: animated, completion: completion)
    }

    
    
    
}

