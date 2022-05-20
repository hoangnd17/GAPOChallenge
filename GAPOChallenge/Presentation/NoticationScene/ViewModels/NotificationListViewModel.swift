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
    var items: Driver<[NotificationItemViewModel]> { get }
}

protocol NotificationListViewModel: NotificationListViewModelInput, NotificationListViewModelOutput { }

final class DefaultNotificationListViewModel: NotificationListViewModel {
    
    private let useCase: FetchListNoficationUseCase

    // MARK: Output
    var items: Driver<[NotificationItemViewModel]> = .empty()

    typealias Dependency = FetchListNoficationUseCase
    
    init(with useCase: Dependency) {
        self.useCase = useCase
    }
    
    private func loadItems() {
       items = useCase.execute()
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
