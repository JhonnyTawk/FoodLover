//
//  APIClient.swift
//  FoodLover
//
//  Created by Jhonny on 11/6/21.
//

import Foundation

protocol Request {
    var path: String { get }
}

extension Request {
    
    func build() -> URLRequest {
        //Build the request
        let mainURL = URL(string: path)!
        var request = URLRequest(url: mainURL)
        request.httpMethod = "GET"
        return request
    }
}

protocol service {
    func getRequest(completion: @escaping (Result<Data, Error>) -> Void)
}

class NetworkService: service {
    
    private let modifiers: URLRequest
    
    init(modifiers: URLRequest) {
        self.modifiers = modifiers
    }
    
    func getRequest(completion: @escaping (Result<Data, Error>) -> Void) {
        
        let request = modifiers
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response, error) in
           if let error = error {
               completion(.failure(error))
               return
           }
           guard let data = data else {
               //Error
               return
           }
           completion(.success(data))
       }
       task.resume()
    }
}
