//
//  NoficationsUseCaseTest.swift
//  GAPOChallengeTests
//
//  Created by Nguyen Dinh Hoang on 5/20/22.
//

import XCTest
import RxSwift
import RxCocoa

class NoficationsUseCaseTest: XCTestCase {
    
    private var notifications: [Notification]!
    private var sut: NotificationsUseCase!
    private var bag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        notifications = []
        sut = MockNotificationsUseCase(factory: DependencyContainer.shared)
        bag = DisposeBag()
    }
    
    override func tearDown() {
        notifications =  nil
        sut = nil
        bag = nil
        super.tearDown()
    }
    
    func testGetNotifications_hasAtLeastOneItem() {
        // given
        let expectation = expectation(description: "Notifaction page has at least one notification ")
        expectation.expectedFulfillmentCount = 1
        
        // when
        sut.notifications()
            .subscribe(onNext: { [weak self] result in
                switch result {
                case .success(let notificatons):
                    self?.notifications = notificatons
                case .failure(_):
                    break
                }
                expectation.fulfill()
            })
            .disposed(by: bag)
        
        // then
        waitForExpectations(timeout: 3.0)
        XCTAssertTrue(notifications.count > 0)
    }
    
    func testGetNotificationsByQuey_hasAtLeastOneItem_ifQueryIsValid() {
        // given
        let expectation = expectation(description: "Notification page has at least one notification ")
        expectation.expectedFulfillmentCount = 1
        let query = NotificationQuery(text: "Chu Đức Minh")
        
        // when
        sut.notificationsByQuery(query)
            .subscribe(onNext: { [weak self] result in
                switch result {
                case .success(let notifications):
                    self?.notifications = notifications
                case .failure(_):
                    break
                }
                expectation.fulfill()
            })
            .disposed(by: bag)
        
        // then
        waitForExpectations(timeout: 3.0)
        XCTAssertTrue(notifications.count > 0)
    }
    
    func testGetNotificationsByQuey_hasAtNoItems_ifQueryIsInvalid() {
        // given
        let expectation = expectation(description: "Notification page has at least one notification ")
        expectation.expectedFulfillmentCount = 1
        let query = NotificationQuery(text: "Khong ton tai")
        
        // when
        sut.notificationsByQuery(query)
            .subscribe(onNext: { [weak self] result in
                switch result {
                case .success(let notifications):
                    self?.notifications = notifications
                case .failure(_):
                    break
                }
                expectation.fulfill()
            })
            .disposed(by: bag)
        
        // then
        waitForExpectations(timeout: 3.0)
        XCTAssertTrue(notifications.count == 0)
    }
    
}
