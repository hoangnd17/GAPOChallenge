//
//  DependencyContainer.swift
//  GAPOChallenge
//
//  Created by Nguyen Dinh Hoang on 5/22/22.
//

import Foundation

final class DependencyContainer {
   static let shared = DependencyContainer()
    
    private init() { }
}

extension DependencyContainer: RepositoryFactory {
    func makeNotificationRepository() -> NotificationRepository {
        return MockNotificationRepository()
    }
}

extension DependencyContainer: UseCaseFactory {
    func makeNotificationsUseCase() -> NotificationsUseCase {
        return DefaultNotificationsUseCase(factory: self)
    }
}

extension DependencyContainer: ViewModelFactory {
    func makeNotificationListViewModel() -> NotificationListViewModel {
        return DefaultNotificationListViewModel(factory: self)
    }
}

protocol ViewModelFactory {
    func makeNotificationListViewModel() -> NotificationListViewModel
}

protocol UseCaseFactory {
    func makeNotificationsUseCase() -> NotificationsUseCase
}

protocol RepositoryFactory {
    func makeNotificationRepository() -> NotificationRepository
}
