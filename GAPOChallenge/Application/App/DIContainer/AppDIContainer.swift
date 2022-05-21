//
//  DependencyContainer.swift
//  GAPOChallenge
//
//  Created by Nguyen Dinh Hoang on 5/22/22.
//

import Foundation

final class DependencyContainer {
   
}

extension DependencyContainer: RepositoryFactory {
    func makeNotificationRepository() -> NotificationRepository {
        return MockNotificationRepository()
    }
}

extension DependencyContainer: UseCaseFactory {
    func makeNotificationsUseCase() -> NotificationsUseCase {
        let repository = makeNotificationRepository()
        return MockNotificationsUseCase(repository: repository)
    }
}

extension DependencyContainer: ViewModelFactory {
    func makeNotificationListViewModel() -> NotificationListViewModel {
        let useCase = makeNotificationsUseCase()
        return DefaultNotificationListViewModel(with: useCase)
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
