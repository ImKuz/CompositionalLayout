//
//  AppDelegate.swift
//  CompositionalLayout
//
//  Created by Mikhail Kuzmin on 13.03.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let controller = HomeViewController()
        let presenter = HomePresenterImpl(view: controller)
        let interactor = HomeInteractorImpl(presenter: presenter)
        controller.interactor = interactor

        window = UIWindow()
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
        return true
    }
}

