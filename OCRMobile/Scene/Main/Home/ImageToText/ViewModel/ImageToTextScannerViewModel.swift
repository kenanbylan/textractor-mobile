//
//  LanguageViewModel.swift
//  OCRMobile
//
//  Created by Kenan Baylan on 20.05.2023.
//

import Foundation
import ProgressHUD

class ImageToTextScannerViewModel {
    
    
    static let shared = ImageToTextScannerViewModel()
    var coordinator: ImageToTextCoordinator?
    
    
    let manager = HomeManager.shared
    
    
    
    //array is language
    var textLanguage = [Languages]()
    var textViewData: String?
    
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
                self.successCallback?()
            }
            
        }
    }
    
    
    
    func postImagetoText(imageUrl: String, lang: String, completion: @escaping () -> Void) {
        
        
        ProgressHUD.animationType = .multipleCircleScaleRipple
        ProgressHUD.colorAnimation = UIColor(named: "text-color")!
        ProgressHUD.show("Image Scanner.")
        
        manager.postRecognize(imageUrl: imageUrl, lang: lang) { [weak self] recognize, error in
            if let error = error {
                ProgressHUD.showFailed()
                print("error: ", error)
                self?.errorCallback?(error.localizedDescription)
            }

            if let recognize = recognize {
                ProgressHUD.showSucceed()
                self?.textViewData = recognize.data
                print("View Model textViewData: ", self?.textViewData)
            } else {
                ProgressHUD.showFailed()
            }
            
            completion() // Call the completion closure after the operation is finished
        }
    }
    
    
    
    
    
    
    
}
