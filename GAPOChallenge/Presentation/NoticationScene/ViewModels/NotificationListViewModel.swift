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
    func didBeginSearch()
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
        let initial =
            Observable.merge(
                viewDidLoadProperty.asObservable(),
                viewWillAppearProperty.asObservable().skip(1),
                didCancelSearchProperty.asObservable()
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
        let didSearch =
            didSearchWithQueryProperty
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
        
        let startSearch = didBeginSearchProperty.map { [NotificationItemViewModel]() }
        
        self.notifications =
            Driver.merge(
                initial.asDriver(onErrorJustReturn: []),
                didSearch.asDriver(onErrorJustReturn: []),
                startSearch.asDriver(onErrorJustReturn: [])
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
    
    private let didBeginSearchProperty = PublishSubject<Void>()
    func didBeginSearch() {
        didBeginSearchProperty.onNext(())
    }
    
    private let didSearchWithQueryProperty = PublishSubject<String>()
    func didSearch(query: String) {
        didSearchWithQueryProperty.onNext(query)
    }
    
    private let didCancelSearchProperty = PublishSubject<Void>()
    func didCancelSearch() {
        didCancelSearchProperty.onNext(())
    }
    
    func didSelectItem(at index: Int) {
        
    }
}
