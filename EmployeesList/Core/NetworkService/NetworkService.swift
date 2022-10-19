//
//  NetworkService.swift
//  EmployeesList
//
//  Created by Tatiana Ampilogova on 7/20/22.
//

import Foundation

public protocol NetworkService {
    /// Send request to API
    func send(_ request: NetworkRequest, completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable?
}

class NetworkServiceImpl: NetworkService {
    private let urlSession = URLSession.shared
    
    func send(_ request: NetworkRequest, completion: @escaping (Result<Data, Error>) -> Void)  -> Cancellable? {
        guard let request = request.buildRequest() else {
            completion(.failure(NSError("Invalid network request")))
            return nil
        }
        let dataTask = urlSession.dataTask(with: request) { data, responce, error in
            if (error as? NSError)?.code == NSURLErrorCancelled {
                return
            }
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(NSError("Unknown network error")))
            }
        }
        dataTask.resume()
        
        return dataTask
    }
}
