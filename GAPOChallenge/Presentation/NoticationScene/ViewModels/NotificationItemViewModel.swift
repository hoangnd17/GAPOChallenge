//
//  NotificationItemViewModel.swift
//  GAPOChallenge
//
//  Created by Nguyen Dinh Hoang on 5/20/22.
//

import Foundation

protocol NotificationItemViewModelInput {
    
}

protocol NotificationItemViewModelOutput {
    
}

protocol NotificationItemViewModel: NotificationItemViewModelInput, NotificationItemViewModelOutput { }

final class DefaultNotificationItemViewModel: NotificationItemViewModel {
    
}
