//  NetworkManager.swift
//  OCRMobile
//  Created by Kenan Baylan on 8.05.2023.



import Foundation


class NetworkManager {
    
    static let shared = NetworkManager()
    
    func request<T: Codable>(responseType: T.Type,
                             
                             url: String,
                             httpMethod: HTTPMethods,
                             header: [String:String]? = nil,
                             body: Data? = nil,
                             completion: @escaping((Result<(T), NetworkError>) -> Void)) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            
           
            return
        }
        
        
        
        var request = URLRequest(url: url)
        
        request.httpMethod = httpMethod.rawValue
        request.allHTTPHeaderFields = header
        request.httpBody = body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        let dataTask = URLSession(configuration: .default).dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.unknownError(error)))
            } else {
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(.invalidResponse))
                    return
                }
                guard let data = data else {
                    completion(.failure(.invalidData))
                    return
                }
            
                
                
                if (200...299).contains(httpResponse.statusCode) {
                    
                    do {
                        let result = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(result))
                    } catch {
                        completion(.failure(.parseError))
                    }
                } else {
                    do {
                        let error = try JSONDecoder().decode(APIError.self, from: data)
                        completion(.failure(.apiError(error)))
                    } catch {
                        completion(.failure(.parseError))
                    }
                }
            }
        }
        
        dataTask.resume()
    }    
}
