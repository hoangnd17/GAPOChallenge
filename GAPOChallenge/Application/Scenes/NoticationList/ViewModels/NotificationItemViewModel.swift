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
    let imagePath: String
    let timestamp: String
    
    init(notification: Notification) {
        self.text = notification.message.text
        self.imagePath = notification.image
        let date = Date(timeIntervalSince1970: notification.createdAt)
        self.timestamp = date.toString()
    }
    
}

extension Date {
    func toString(withFormat format: String = "dd/MM/yyyy, hh:mm") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
