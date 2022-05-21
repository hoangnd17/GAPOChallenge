//
//  NotificationItemViewModel.swift
//  GAPOChallenge
//
//  Created by Nguyen Dinh Hoang on 5/20/22.
//

import Foundation
import UIKit

final class NotificationItemViewModel {
    
    let text: String
    let image: String
    let timestamp: TimeInterval
    
    init(notification: Notification) {
        self.text = notification.message.text
        self.image = notification.image
        self.timestamp = notification.createdAt
    }
    
}

