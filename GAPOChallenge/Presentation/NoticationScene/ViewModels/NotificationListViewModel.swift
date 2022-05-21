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
    private let useCase: FetchListNoficationUseCase

    // MARK: Output
    var reloadData: Driver<[NotificationItemViewModel]> = .empty()

    typealias Dependency = FetchListNoficationUseCase
    
    init(with useCase: Dependency) {
        self.useCase = useCase
        self.reloadData = useCase.execute()
            .map({ result -> [Notification] in
                switch result {
                case .success(let notifications):
                    return notifications
                case .failure(_):
                    return []
                }
            })
            .map { $0.map(NotificationItemViewModel.init) }
            .asDriver(onErrorJustReturn: [])
    }
    
    private func loadItems() {
        reloadData = useCase.execute()
            .map({ result -> [Notification] in
                switch result {
                case .success(let notifications):
                    return notifications
                case .failure(_):
                    return []
                }
            })
            .map { $0.map(NotificationItemViewModel.init) }
            .asDriver(onErrorJustReturn: [])
    }
    
}

extension DefaultNotificationListViewModel {
    
    func viewDidLoad() {
        loadItems()
    }
    
    func didSelectItem(at index: Int) {
        
    }
    
    func didSearch(query: String) {
        
    }
    
    func didCancelSearch() {
        
    }
}
