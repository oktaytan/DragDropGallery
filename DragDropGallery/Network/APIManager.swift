//
//  APIManager.swift
//  DragDropGallery
//
//  Created by Oktay Tanrıkulu on 29.01.2023.
//

import Foundation

final class APIManager {
    
    private class func buildURL(endpoint: Endpoint) -> URLComponents {
        var components = URLComponents()
        components.scheme = endpoint.scheme.rawValue
        components.host = endpoint.baseURL
        components.path = endpoint.path
        components.queryItems = endpoint.parameters
        return components
    }
    
    class func request<T: Decodable>(endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = buildURL(endpoint: endpoint).url else {
            print("URL creation error")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                completion(.failure(error))
                print("Unknown error", error)
                return
            }
            
            guard response != nil, let data = data else {
                return
            }
            
            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                completion(.success(response))
            } catch {
                let error = NSError(domain: "com.cawis.DragDropGallery",
                                    code: 200,
                                    userInfo: [
                                        NSLocalizedDescriptionKey : "Parsing Error"
                                    ])
                completion(.failure(error))
            }
        }
        
        dataTask.resume()
    }
}
