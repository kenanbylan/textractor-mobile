//
//  LoadingViewController.swift
//  OCRMobile
//
//  Created by Kenan Baylan on 12.05.2023.
//

import UIKit

class LoadingViewController: UIViewController, Storyboarded {
    
    let viewModel = LoadingViewModel()
    
    static let identifier = String(describing: LoadingViewController.self)

    private let defaults = UserDefaults.standard

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        configureViewModel()
    }
    
    
    func configureViewModel(){
        viewModel.coordinator = LoadingCoordinator(navigationController: navigationController ?? UINavigationController())
    }
    
    
    @IBAction func getStartedButtonTapped(_ sender: Any) {
        viewModel.nextLogin()
    }
    
    
}
