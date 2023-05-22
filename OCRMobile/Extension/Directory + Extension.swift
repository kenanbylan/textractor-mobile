//
//  Directory + Extension .swift
//  OCRMobile
//
//  Created by Kenan Baylan on 20.05.2023.
//

import Foundation
import UIKit

import Photos

func convertImageToBase64(image: UIImage) -> String? {
    
    guard let imageData = image.jpegData(compressionQuality: 1.0) else {
        return nil
    }
    
    let base64String = imageData.base64EncodedString(options: .lineLength76Characters)
    return base64String
    
}
