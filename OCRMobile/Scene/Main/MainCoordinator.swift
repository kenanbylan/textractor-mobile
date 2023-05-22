//  MainCoordinator.swift
//  OCRMobile
//  Created by Kenan Baylan on 11.05.2023.

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    
    
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(MainTabbarController.self)")
        navigationController.show(controller, sender: nil)
        
    }
}


