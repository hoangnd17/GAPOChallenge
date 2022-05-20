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
