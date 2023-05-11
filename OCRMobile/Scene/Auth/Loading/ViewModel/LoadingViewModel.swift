//
//  LoadingViewModel.swift
//  OCRMobile
//
//  Created by Kenan Baylan on 11.05.2023.
//

import Foundation


class LoadingViewModel {
    
    var coordinator: LoadingCoordinator?
    
    func nextLogin() {
        coordinator?.showHome()
    }
     
    
}
