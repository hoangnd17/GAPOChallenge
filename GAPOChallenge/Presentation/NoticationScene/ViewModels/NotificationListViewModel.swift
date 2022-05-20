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
}

protocol NotificationListViewModelOutput {
    var items: Driver<[NotificationItemViewModel]> { get }
}

protocol NotificationListViewModel: NotificationListViewModelInput, NotificationListViewModelOutput { }

final class DefaultNotificationListViewModel: NotificationListViewModel {

    // MARK: Output
    var items: Driver<[NotificationItemViewModel]> = .empty()
    
    // MARK: Input
    
    func viewDidLoad() {
        
    }
    
    func didSelectItem(at index: Int) {
        
    }
    
    func didSearch(query: String) {
        
    }
}
