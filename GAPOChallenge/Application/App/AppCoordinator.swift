//
//  AppCoordinator.swift
//  GAPOChallenge
//
//  Created by Nguyen Dinh Hoang on 5/19/22.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    func start()
}

final class AppCoordinator: Coordinator {
    private let window: UIWindow
    private let rootVC: UINavigationController = UINavigationController()
    private let dependencyContainer: DependencyContainer
    
    init(with window: UIWindow, dependencyContainer: DependencyContainer) {
        self.window = window
        self.dependencyContainer = dependencyContainer
    }
    
    func start() {
        let notificationListVC = NotificationListViewController(factory: dependencyContainer)
        rootVC.pushViewController(notificationListVC, animated: false)
        
        window.rootViewController = rootVC
        window.makeKeyAndVisible()
    }
}
