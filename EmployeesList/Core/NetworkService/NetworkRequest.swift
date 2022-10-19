//
//  NetworkRequest.swift
//  EmployeesList
//
//  Created by Tatiana Ampilogova on 7/20/22.
//

import Foundation

public struct NetworkRequest {
    
    private static let endpoint = "https://s3.amazonaws.com/sq-mobile-interview/"
    private var url: String
    
    init(endpointAPI: String) {
        self.url = Self.endpoint + endpointAPI
    }
    
    init(url: String) {
        self.url = url
    }
    
    func buildRequest() -> URLRequest? {
        guard let url = URL(string: self.url) else {
            return nil
        }
        let request = URLRequest(url: url)
        return request
    }
}
