//
//  MainHelper.swift

//  Created by Kenan Baylan on 8.05.2023.
//

import Foundation


enum HomeEnpoint: String {
    
    case textract = "api/"
    case getLanguage = "api/get-languages"
    
    var path: String {
        NetworkHelper.shared.requestURL(endPoint: self.rawValue)
    }
}

