//
//  UIView.swift
//  EmployeesList
//
//  Created by Tatiana Ampilogova on 7/20/22.
//

import UIKit

extension UIView {
    
    public func makeRounded() {
        self.layoutIfNeeded()
        layer.cornerRadius = self.frame.size.height / 2.0
        layer.masksToBounds = true
    }
}
