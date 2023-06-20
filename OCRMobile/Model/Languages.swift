//
//  Languages.swift
//  OCRMobile
//
//  Created by Kenan Baylan on 20.05.2023.
//

import Foundation


struct Languages: Codable {
    
    let id: String?
    let code: String?
    let language: String?
    let version: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case code = "lang_code"
        case language
        case version = "__v"
    }
    
}
