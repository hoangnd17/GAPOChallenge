//
//  FetchListNotificationUseCase.swift
//  GAPOChallenge
//
//  Created by Nguyen Dinh Hoang on 5/20/22.
//

import Foundation
import RxSwift

typealias ResultValue = Result<[Notification], Error>
protocol FetchListNoficationUseCase {
    func execute() -> Observable<ResultValue>
}

final class DefaultFetchListNoficationUseCase: FetchListNoficationUseCase {
    
    
    private let repository: NotificationRepository
    
    init(repository: NotificationRepository) {
        self.repository = repository
    }
    
    func execute() -> Observable<ResultValue> {
        return Observable<ResultValue>.create { observer in
            
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
