//  NetworkManager.swift
//  OCRMobile
//  Created by Kenan Baylan on 8.05.2023.

import Foundation
import Alamofire


struct NetworkManager {
    
    static let shared = NetworkManager()
    
    
    func request<T: Codable>(type: T.Type,
                             url: String,
                             method: HTTPMethod,
                             parameters: [String: Any]? = nil, // Additional parameters
                             completion: @escaping((Result<T, ErrorTypes>)->())) {
        AF.request(url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "", method: method,parameters: parameters).responseData { response in
            switch response.result {
            case .success(let data):
                self.handleResponse(data: data) { response in
                    completion(response)
                }
                
            case .failure(_):
                completion(.failure(.generalError))
            }
        }
    }
    
    fileprivate func handleResponse<T: Codable>(data: Data, completion: @escaping((Result<T, ErrorTypes>)->())) {
        
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            completion(.success(result))
            
        } catch {
            completion(.failure(.invalidData))
        }
    }
    
    
}
