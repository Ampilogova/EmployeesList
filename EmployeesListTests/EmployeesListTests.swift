//
//  EmployeesListTests.swift
//  EmployeesListTests
//
//  Created by Tatiana Ampilogova on 7/20/22.
//

import XCTest
@testable import EmployeesList

class EmployeesListTests: XCTestCase {
    
    let fakeNetworkService = NetworkServiceFakeImpl()
    let fakeData = FakeData()
    
    func testEmployeeService() throws {
        fakeNetworkService.data = fakeData.successResponse
        
        let employeeService = EmployeeServiceImpl(networkService: fakeNetworkService)
        var employees = [Employee]()
        employeeService.loadEmployees { result in
            switch result {
            case .success(let employeesResult):
                employees = employeesResult
            case .failure(let error):
                print(error)
            }
        }
        
        XCTAssertEqual(employees.count, 2)
        let employee = employees[0]
        XCTAssertEqual(employee.name, "Justine Mason")
        let url = URL(string: "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/small.jpg")
        XCTAssertEqual(employee.photoURL, url)
    }
    
    func testEmployeeService_brokenResponce() throws {
        fakeNetworkService.data = fakeData.brokenResponse
        
        let employeeService = EmployeeServiceImpl(networkService: fakeNetworkService)
        var error: Error? = nil
        employeeService.loadEmployees { result in
            switch result {
            case .failure(let  resultError):
                error = resultError
            default: break
            }
        }
        XCTAssertNotNil(error)
        XCTAssertEqual(error?.localizedDescription, "The data couldn’t be read because it is missing.")
    }
    
    func testEmployeeService__emptyState() throws {
        fakeNetworkService.data = fakeData.emptyResponse
        
        let employeeService = EmployeeServiceImpl(networkService: fakeNetworkService)
        var employees = [Employee]()
        employeeService.loadEmployees { result in
            switch result {
            case .success(let employeesResult):
                employees = employeesResult
            case .failure(let error):
                print(error)
            }
        }
        XCTAssertEqual(employees.count, 0)
    }
    
    func testEmployeeService_networkError() throws {
        fakeNetworkService.error = fakeData.networkErrorResponse
        
        let employeeService = EmployeeServiceImpl(networkService: fakeNetworkService)
        var error: Error? = nil
        employeeService.loadEmployees { result in
            switch result {
            case .failure(let  resultError):
                error = resultError
            default: break
            }
        }
        XCTAssertNotNil(error)
        XCTAssertEqual(error?.localizedDescription, "Connection error")
    }
}
