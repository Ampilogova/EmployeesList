//
//  Employee.swift
//  EmployeesList
//
//  Created by Tatiana Ampilogova on 7/20/22.
//

import Foundation

enum EmployeeType: String, Decodable {
    case fullTime = "FULL_TIME"
    case partTime = "PART_TIME"
    case contractor = "CONTRACTOR"
    
    var title: String {
        switch self {
        case .fullTime:
            return "Full-time"
        case .partTime:
            return "Part-time"
        case .contractor:
            return "Contractor"
        }
    }
}

struct Employee: Decodable {
    var id: String
    var name: String
    var email: String
    var team: String
    var photoURL: URL?
    var employeeType: EmployeeType

    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case name = "full_name"
        case email = "email_address"
        case team = "team"
        case photoURL = "photo_url_small"
        case employeeType = "employee_type"
    }
}
