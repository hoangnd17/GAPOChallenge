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
    
    init(with window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let notificationListVC = NotificationListViewController()
        rootVC.pushViewController(notificationListVC, animated: false)
        
        window.rootViewController = rootVC
        window.makeKeyAndVisible()
    }
}
