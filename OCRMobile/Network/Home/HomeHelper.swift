//
//  MainHelper.swift

//  Created by Kenan Baylan on 8.05.2023.
//

import Foundation


enum HomeEnpoint: String {
    
    case getLanguage = "get-languages"
    case postRecognize = "recognize"
    
    var path: String {
        NetworkHelper.shared.requestURL(endPoint: self.rawValue)
    }
    
}

