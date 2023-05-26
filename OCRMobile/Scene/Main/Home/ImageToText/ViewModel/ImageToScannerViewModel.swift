//  HomeViewModel.swift
//  OCRMobile
//  Created by Kenan Baylan on 11.05.2023.


import Foundation
import ProgressHUD

class ImageToScannerViewModel {
    
    static let shared = ImageToScannerViewModel()
    
    var coordinator: ImageToPdfCoordinator?
    let manager = HomeManager.shared //home manager hata olabilir.
    
    var errorCallback: ((String)->())?
    var successCallback: (()->())?
    
    
    var textViewData: String?
    
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
 
