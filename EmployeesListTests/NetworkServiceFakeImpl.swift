//
//  NetworkServiceFakeImpl.swift
//  EmployeesListTests
//
//  Created by Tatiana Ampilogova on 7/20/22.
//

import Foundation
import EmployeesList

class NetworkServiceFakeImpl: NetworkService {
    
    var data = Data()
    var error: Error?
    
     func send(_ request: NetworkRequest, completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable? {
        if let error = error {
            completion(.failure(error))
        } else {
            completion(.success(data))
        }
        
        return nil
    }
}
