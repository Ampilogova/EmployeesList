//
//  Alert.swift
//  EmployeesList
//
//  Created by Tatiana Ampilogova on 7/22/22.
//

import UIKit

extension UIViewController {
    public func showAlert(title: String, message: String, handler: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            handler?()
        }))
        present(alertController, animated: true, completion: nil)
    }
}
