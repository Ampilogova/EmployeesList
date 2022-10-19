//
//  SceneDelegate.swift
//  EmployeesList
//
//  Created by Tatiana Ampilogova on 7/20/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let networkService = NetworkServiceImpl()
        let imageService = ImageServiceImpl(networkService: networkService)
        let employeeService = EmployeeServiceImpl(networkService: networkService)
        let employeeViewController = EmployeesViewController(employeeService: employeeService, imageService: imageService)
        let navigationViewController = UINavigationController(rootViewController: employeeViewController)
        window.rootViewController = navigationViewController
        window.makeKeyAndVisible()
        self.window = window
    }
}

