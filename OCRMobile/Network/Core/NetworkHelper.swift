//  NetworkHelper.swift
//  OCRMobile
//  Created by Kenan Baylan on 8.05.2023.


import Foundation

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
}


enum NetworkError: Error {
    
    case invalidURL
    case invalidResponse
    case invalidData
    case parseError
    case unknownError(Error)
    case apiError(APIError)
}

struct APIError: Decodable, Error {
    
    
    let statusCode: Int?
    let reason: String?
    let message: String?
}

class NetworkHelper {
    
    static let shared = NetworkHelper()
    
    private let baseURL = "http://localhost:3000/api"
    
    
    
    
    func requestURL(endPoint: String) -> String {
        baseURL + endPoint
        
      
        
    }
    
    
}
