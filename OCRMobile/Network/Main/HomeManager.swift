//
//  HomeManager.swift
//  OCRMobile
//
//  Created by Kenan Baylan on 11.05.2023.
//

import Foundation


protocol HomeManagerProtocol {
    func homeRequest(user: User, completion: @escaping ((Result<User, APIError>) -> Void))
}

class HomeManager: HomeManagerProtocol {
    static let shared = HomeManager()
    
    func homeRequest(user: User, completion: @escaping ((Result<User, APIError>) -> Void)){
        guard let body = try? JSONEncoder().encode(user) else {
            return
        }
        
        NetworkManager.shared.request(responseType: User.self,
                                      url: HomeEnpoint.textract.path,
                                      httpMethod: .post,
                                      body: body) { response in
            switch (response) {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                switch (error) {
                case .apiError(let apiError):
                    completion(.failure(apiError))
                default:
                    let apiError = APIError(statusCode: 0, reason: "Connection Error", message: "Please check your internet connection!")
                    completion(.failure(apiError))
                }
            }
        }
    }
}
