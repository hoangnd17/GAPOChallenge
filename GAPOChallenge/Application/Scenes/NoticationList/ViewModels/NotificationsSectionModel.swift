//
//  NotificationsSectionModel.swift
//  GAPOChallenge
//
//  Created by Nguyen Dinh Hoang on 5/22/22.
//

import Foundation
import RxDataSources


struct NotificationSectionData {
    typealias Item = NotificationItemViewModel
    var items: [NotificationItemViewModel]
}

extension NotificationSectionData: SectionModelType {
    init(original: NotificationSectionData, items: [NotificationItemViewModel]) {
        self = original
        self.items = items
    }
}
