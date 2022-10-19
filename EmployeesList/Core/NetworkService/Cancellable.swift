//
//  Cancellable.swift
//  EmployeesList
//
//  Created by Tatiana Ampilogova on 7/20/22.
//

import Foundation

public protocol Cancellable {
    func cancel()
}

extension URLSessionTask: Cancellable {
}
