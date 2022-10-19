//
//  EmployeeService.swift
//  EmployeesList
//
//  Created by Tatiana Ampilogova on 7/20/22.
//

import Foundation

protocol EmployeesService {
    /// Loading list of employees from the backend
    @discardableResult func loadEmployees(completion: @escaping (Result<[Employee],Error>) -> Void) -> Cancellable?
}

class EmployeeServiceImpl: EmployeesService {
    
    private let api = "employees.json"
    private let decoder = JSONDecoder()
    private let networkSerivce: NetworkService
    
    init(networkService: NetworkService) {
        self.networkSerivce = networkService
    }
    
    @discardableResult func loadEmployees(completion: @escaping (Result<[Employee], Error>) -> Void) -> Cancellable? {

        let request = NetworkRequest(endpointAPI: api)
        let task = networkSerivce.send(request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                do {
                    let employees = try self.decoder.decode(EmployeesResult.self, from: data)
                    completion(.success(employees.employees))
                }
                catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        return task
    }
}
