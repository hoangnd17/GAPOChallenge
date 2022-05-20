//
//  Notification.swift
//  GAPOChallenge
//
//  Created by Nguyen Dinh Hoang on 5/20/22.
//

import Foundation

// MARK: - Notification Page
struct NotificationPage {
    let notifications: [Notification]
}

// MARK: - Notification
struct Notification: Codable {
    let message: Message
    var image: String?
}

// MARK: - Message
struct Message: Codable {
    let highlights: String
    let text: String
    let timestamp: String
}

// MARK: Notification Query
struct NotificationQuery {
    let query: String
}
