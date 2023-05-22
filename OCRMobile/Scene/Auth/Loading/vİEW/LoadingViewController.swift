//
//  LoadingViewController.swift
//  OCRMobile
//
//  Created by Kenan Baylan on 12.05.2023.
//

import UIKit

class LoadingViewController: UIViewController, Storyboarded {
    
    let viewModel = LoadingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
    }
    
    
    func configureViewModel(){
        viewModel.coordinator = LoadingCoordinator(navigationController: navigationController ?? UINavigationController())
    }

    @IBAction func skipButtonTapped(_ sender: Any) {
        print("skip button tapped")
    }
    
    @IBAction func getStartedButtonTapped(_ sender: Any) {
        viewModel.nextLogin()
    }
    
}
