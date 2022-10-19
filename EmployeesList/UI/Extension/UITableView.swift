//
//  UITableView.swift
//  EmployeesList
//
//  Created by Tatiana Ampilogova on 7/22/22.
//

import UIKit

extension UITableView {
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.textColor = .gray
        messageLabel.textAlignment = .center
        messageLabel.font = .systemFont(ofSize: 17, weight: .medium)
        
        self.backgroundView = messageLabel
    }
    
    func cleanEmptyMessage() {
        self.backgroundView = nil
    }
}
