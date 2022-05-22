//
//  NotificationRepository.swift
//  GAPOChallenge
//
//  Created by Nguyen Dinh Hoang on 5/20/22.
//

import Foundation

protocol NotificationRepository {
    func fetchNotifications(completion: @escaping (Result<NotificationPage, Error>) -> Void)
    func searchNotificationsBy(_ query: NotificationQuery, completion: @escaping (Result<NotificationPage, Error>) -> Void)
}

struct MockNotificationRepository: NotificationRepository {

    func fetchNotifications(completion: @escaping (Result<NotificationPage, Error>) -> Void) {
        completion(.success(Mock.page))
    }
    
    func searchNotificationsBy(_ query: NotificationQuery, completion: @escaping (Result<NotificationPage, Error>) -> Void) {
        let searchingText = query.text
        let notifications = Mock.page.data
        let filterResult =
        notifications.filter { $0.message.text.contains(searchingText) }
        let ret = NotificationPage(data: filterResult)
        
        completion(.success(ret))
    }
}

