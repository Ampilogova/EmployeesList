//
//  Extension+NSError.swift
//  EmployeesList
//
//  Created by Tatiana Ampilogova on 7/20/22.
//

import Foundation

extension NSError {
    
    convenience init(_ description: String) {
        self.init(domain: "Local domain", code: -1, userInfo: [NSLocalizedDescriptionKey: description])
    }
}
