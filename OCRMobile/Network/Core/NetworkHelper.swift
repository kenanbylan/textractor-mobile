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
    case apiError(ErrorTypes)
}


enum ErrorTypes: String, Error {
    case invalidData = "Invalid data"
    case invalidURL = "Invalid url"
    case generalError = "An error happened"
}



class NetworkHelper {
    
    static let shared = NetworkHelper()
    private let baseURL = "https://textractor.marun.tk/api/"
    
    //https://textractor.marun.tk/api/get-languages
    
    func requestURL(endPoint: String) -> String {
        baseURL + endPoint
    }
    
    
}
