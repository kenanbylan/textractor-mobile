//
//  LoadingCoordinator.swift
//  OCRMobile
//
//  Created by Kenan Baylan on 11.05.2023.
//

import Foundation
import UIKit

class LoadingCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
        let controller = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "\(LoadingViewController.self)")
        navigationController.show(controller, sender: nil)
        
    }
    
    
    
    func showHome() {
        let controller = MainTabbarController.instantiate(name: .main)
        navigationController.setViewControllers([controller], animated: true)
        print("çalışıyor")
        //navigationController.show(controller, sender: nil)
        
    }
    
    
    func presentAlert(_ alertController: UIAlertController, animated: Bool, completion: (() -> Void)?) {
        navigationController.present(alertController, animated: animated, completion: completion)
    }
    

    
    
}
