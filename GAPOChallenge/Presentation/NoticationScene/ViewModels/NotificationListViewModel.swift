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
    var reloadData: Driver<[NotificationItemViewModel]> { get }
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
    var reloadData: Driver<[NotificationItemViewModel]> = .empty()

    init(with useCase: Dependency) {
        self.useCase = useCase
        self.reloadData =
                Observable.merge(
                    viewDidLoadProperty.asObservable(),
                    viewWillAppearProperty.asObservable().skip(1)
                )
                .flatMapLatest {
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
                .asDriver(onErrorJustReturn: [])
    }
    
    private let viewDidLoadProperty = PublishSubject<Void>()
    func viewDidLoad() {
        viewDidLoadProperty.onNext(())
    }
    
    private let viewWillAppearProperty = PublishSubject<Void>()
    func viewWillAppear() {
        viewWillAppearProperty.onNext(())
    }
    
    func didSelectItem(at index: Int) {
        
    }
    
    func didSearch(query: String) {
        
    }
    
    func didCancelSearch() {
        
    }
}
