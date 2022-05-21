//
//  FetchListNotificationUseCase.swift
//  GAPOChallenge
//
//  Created by Nguyen Dinh Hoang on 5/20/22.
//

import Foundation
import RxSwift

typealias NotificationListValue = Result<[Notification], Error>
protocol FetchNoficationListUseCase {
    func execute() -> Observable<NotificationListValue>
}

final class DefaultFetchListNoficationUseCase: FetchNoficationListUseCase {
    
    private let repository: NotificationRepository
    
    init(repository: NotificationRepository) {
        self.repository = repository
    }
    
    func execute() -> Observable<NotificationListValue> {
        return Observable<NotificationListValue>.create { observer in
            
            self.repository.fetchNotificationList { result in
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
