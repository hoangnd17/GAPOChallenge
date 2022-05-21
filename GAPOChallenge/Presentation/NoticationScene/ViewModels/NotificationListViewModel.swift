//
//  NotificationListViewMode.swift
//  GAPOChallenge
//
//  Created by Nguyen Dinh Hoang on 5/20/22.
//

import Foundation
import RxSwift
import RxCocoa

protocol NotificationListViewModelInput {
    func viewDidLoad()
    func viewWillAppear()
    func didSelectItem(at index: Int)
    func didSearch(query: String)
    func didCancelSearch()
}

protocol NotificationListViewModelOutput {
    var notifications: Driver<[NotificationItemViewModel]> { get }
}

protocol NotificationListViewModel: NotificationListViewModelInput, NotificationListViewModelOutput {
    var inputs: NotificationListViewModelInput { get }
    var outputs: NotificationListViewModelOutput { get }
}

final class DefaultNotificationListViewModel: NotificationListViewModel {
    
    var inputs: NotificationListViewModelInput { return self }
    var outputs: NotificationListViewModelOutput { return self }
    
    typealias Dependency = NotificationsUseCase
    private let useCase: NotificationsUseCase
    
    // MARK: Output
    var notifications: Driver<[NotificationItemViewModel]> = .empty()
    
    init(with useCase: Dependency) {
        self.useCase = useCase
        let subject1 =
            Observable.merge(
                viewDidLoadProperty.asObservable(),
                viewWillAppearProperty.asObservable().skip(1)
            )
            .flatMapLatest { () -> Observable<[NotificationItemViewModel]> in
               return useCase.notifications()
                    .map({ result -> [Notification] in
                        switch result {
                        case .success(let notifications):
                            return notifications
                        case .failure(_):
                            return []
                        }
                    })
                    .map { $0.map(NotificationItemViewModel.init) }
            }
        let subject2 =
            didSearchProperty
            .flatMapLatest { text -> Observable<[NotificationItemViewModel]> in
                let query = NotificationQuery(text: text)
                return useCase.notificationsByQuery(query)
                    .map({ result -> [Notification] in
                        switch result {
                        case .success(let notifications):
                            return notifications
                        case .failure(_):
                            return []
                        }
                    })
                    .map { $0.map(NotificationItemViewModel.init) }
            }
        
        self.notifications =
            Driver.merge(
                subject1.asDriver(onErrorJustReturn: []),
                subject2.asDriver(onErrorJustReturn: [])
            )
    }
    
    private let viewDidLoadProperty = PublishSubject<Void>()
    func viewDidLoad() {
        viewDidLoadProperty.onNext(())
    }
    
    private let viewWillAppearProperty = PublishSubject<Void>()
    func viewWillAppear() {
        viewWillAppearProperty.onNext(())
    }
    
    private let didSearchProperty = PublishSubject<String>()
    func didSearch(query: String) {
        didSearchProperty.onNext(query)
    }
    
    func didSelectItem(at index: Int) {
        
    }
    
    func didCancelSearch() {
        
    }
}
