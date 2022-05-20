//
//  NotificationRepository.swift
//  GAPOChallenge
//
//  Created by Nguyen Dinh Hoang on 5/20/22.
//

import Foundation

protocol NotificationRepository {
    func fetchNotificationList(completion: @escaping (Result<NotificationPage, Error>) -> Void)
    func fetchNotificationByQuery(_ query: NotificationQuery, completion: @escaping (Result<NotificationPage, Error>) -> Void)
}

struct MockNotificationRepository: NotificationRepository {
    
    static let page: NotificationPage = {
        guard let path = Bundle.main.path(forResource: "mock", ofType: "json"),
             let url = URL(string: path),
              let data = try? Data(contentsOf: url)
        else {
            fatalError("File mock.json does not exist")
        }

        guard let noticationPage = try? JSONDecoder().decode(NotificationPage.self, from: data)
        else {
            fatalError("Json file has invalid format")
        }
        return noticationPage
    }()
    
    func fetchNotificationList(completion: @escaping (Result<NotificationPage, Error>) -> Void) {
        completion(.success(MockNotificationRepository.page))
    }
    
    func fetchNotificationByQuery(_ query: NotificationQuery, completion: @escaping (Result<NotificationPage, Error>) -> Void) {
        
    }
}
