//
//  LanguageViewModel.swift
//  OCRMobile
//
//  Created by Kenan Baylan on 20.05.2023.
//

import Foundation


class ImageToTextScannerViewModel {
    static let shared = ImageToTextScannerViewModel()
    var coordinator: ImageToPdfCoordinator?
    
    let manager = HomeManager.shared
    
    
    
    //array is language
    var textLanguage = [Languages]()
    
    var errorCallback: ((String)->())?
    var successCallback: (()->())?
    
    
    
    
    //MARK: Http Methodss
    func getLanguage() {
        manager.getLanguages { languages, error in
            if let error = error {
                self.errorCallback?(error.localizedDescription)
            }
            
            if let languages = languages {
                self.textLanguage.append(contentsOf: languages) // there may be an error here.
            } else {
                
            }
        }
        self.successCallback?()
    }
    
    
    
    
    
    
    
}
