//
//  User.swift
//  OCRMobile
//
//  Created by Kenan Baylan on 11.05.2023.
//

import Foundation


struct User: Codable {
    var token: String?
    var name: String?
    var surname:String?
    var email: String?
    var phone:String?
    var password: String?
}
