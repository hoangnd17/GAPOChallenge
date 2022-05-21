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
    
    static let page: NotificationPage = {
        guard let path = Bundle.main.path(forResource: "mock", ofType: "json"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path))
        else {
            fatalError("File mock.json does not exist")
        }

        guard let noticationPage = try? JSONDecoder().decode(NotificationPage.self, from: data)
        else {
            fatalError("Json file has invalid format")
        }
        return noticationPage
    }()
    
    func fetchNotifications(completion: @escaping (Result<NotificationPage, Error>) -> Void) {
        completion(.success(MockNotificationRepository.page))
    }
    
    func searchNotificationsBy(_ query: NotificationQuery, completion: @escaping (Result<NotificationPage, Error>) -> Void) {
        let searchingText = query.text
        let notifications = MockNotificationRepository.page.data
        let filterResult =
        notifications.filter { $0.message.text.contains(searchingText) }
        let ret = NotificationPage(data: filterResult)
        
        completion(.success(ret))
    }
}

