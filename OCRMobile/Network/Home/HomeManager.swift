//  HomeManager.swift
//  OCRMobile
//  Created by Kenan Baylan on 11.05.2023.



import Foundation


protocol HomeManagerProtocol {
    func getLanguages(complete: @escaping(([Languages]?, Error?)->()))
    func postRecognize(imageUrl: URL, lang: String, complete: @escaping((Recognize?, Error?)->()) )
    
}

class HomeManager: HomeManagerProtocol {
   
    static let shared = HomeManager()
    
    func getLanguages(complete: @escaping (([Languages]?, Error?) -> ())) {
        let url = HomeEnpoint.getLanguage.path //get address
        
        NetworkManager.shared.request(type: [Languages].self, url: url, method: .get) { response in
            switch response {
                case .success(let languages):
                complete(languages,nil)
                case .failure(let error):
                    complete(nil, error)
            }
        }
    }
    
    
    func postRecognize(imageUrl: URL, lang: String, complete: @escaping ((Recognize?, Error?) -> ())) {
        let url = HomeEnpoint.postRecognize.path
        
        let parameters: [String: Any] = ["imageUrl": imageUrl, "language":lang]
        
        NetworkManager.shared.request(type: Recognize.self, url: url, method: .post,parameters: parameters) { response in
            
            switch response {
            case .success(let recognize):
                complete(recognize, nil)
                
            case .failure(let error):
                complete(nil, error)
            }
        }
        
    }
    
}

