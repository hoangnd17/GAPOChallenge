//
//  Mock.swift
//  GAPOChallenge
//
//  Created by Nguyen Dinh Hoang on 5/22/22.
//

import Foundation

final class Mock {
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
}
