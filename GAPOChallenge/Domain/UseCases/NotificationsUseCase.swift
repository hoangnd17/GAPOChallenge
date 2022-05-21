//
//  NotificationsUseCase.swift
//  GAPOChallenge
//
//  Created by Nguyen Dinh Hoang on 5/20/22.
//

import Foundation
import RxSwift

typealias NotificationListValue = Result<[Notification], Error>
protocol NotificationsUseCase {
    func notifications() -> Observable<NotificationListValue>
    func notificationsByQuery(_ query: NotificationQuery) -> Observable<NotificationListValue>
}

final class MockNotificationsUseCase: NotificationsUseCase {
    
    private let repository: NotificationRepository
    
    init(repository: NotificationRepository) {
        self.repository = repository
    }
    
    func notifications() -> Observable<NotificationListValue> {
        return Observable<NotificationListValue>.create { observer in
            
            self.repository.fetchNotifications { result in
                switch result {
                case .success(let page):
                    observer.onNext(.success(page.data))
                case .failure(let error):
                    observer.onNext(.failure(error))
                }
            }
            
            return Disposables.create()
        }
    }
    
    func notificationsByQuery(_ query: NotificationQuery) -> Observable<NotificationListValue> {
        return Observable<NotificationListValue>.create { observer in
            self.repository.searchNotificationsBy(query) { result in
                switch result {
                case .success(let page):
                    observer.onNext(.success(page.data))
                case .failure(let error):
                    observer.onNext(.failure(error))
                }
            }
            return Disposables.create()
        }
        
    }
}
