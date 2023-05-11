//
//  LoadingViewController.swift
//  OCRMobile
//
//  Created by Kenan Baylan on 8.05.2023.
//

import UIKit

class LoadingViewController: UIViewController {

    let viewModel = LoadingViewModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func skipButtonTapped(_ sender: Any) {
        print("skip button tapped")
        
    }
    
    
    @IBAction func getStartedButtonTapped(_ sender: Any) {
        viewModel.nextLogin()
        print("clicked")
    }
    
}
