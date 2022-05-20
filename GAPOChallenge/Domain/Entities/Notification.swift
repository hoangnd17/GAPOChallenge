//
//  Notification.swift
//  GAPOChallenge
//
//  Created by Nguyen Dinh Hoang on 5/20/22.
//

import Foundation

// MARK: - Notification Page
struct NotificationPage: Codable {
    let data: [Notification]
}

struct Notification: Codable {
    let id, type: String
    let title: Title
    let message: Message
    let image: String
    let icon: String
    let status: Status
    let subscription: Subscription?
    let readAt: TimeInterval
    let createdAt: TimeInterval
    let updatedAt: TimeInterval
    let receivedAt: TimeInterval
    let imageThumb: String
    let animation: String
    let tracking: String?
    let subjectName: String
    let isSubscribed: Bool
}

// MARK: - Message
struct Message: Codable {
    let text: String
    let highlights: [Highlight]
}

// MARK: - Highlight
struct Highlight: Codable {
    let offset, length: Int
}

enum Status: String, Codable {
    case read = "read"
    case unread = "unread"
}

// MARK: - Subscription
struct Subscription: Codable {
    let targetId: String
    let targetType: TargetType
    let targetName: String?
    let level: Int
}

// MARK: TargetType
enum TargetType: String, Codable {
    case group = "group"
    case post = "post"
    case user = "user"
}

// MARK: Title
enum Title: String, Codable {
    case new = "Bài viết mới"
    case comment = "Bình luận"
    case emotion = "Cảm xúc"
    case friend = "Kết bạn"
}

// MARK: Notification Query
struct NotificationQuery: Codable {
    let text: String
}
