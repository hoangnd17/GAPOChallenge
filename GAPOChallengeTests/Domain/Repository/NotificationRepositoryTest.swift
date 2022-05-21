//
//  NotificationRepositoryTest.swift
//  GAPOChallengeTests
//
//  Created by Nguyen Dinh Hoang on 5/20/22.
//

import XCTest

class NotificationRepositoryTest: XCTestCase {

    private var sut: MockNotificationRepository!
    private var result: [Notification]!
    
    override func setUp() {
        super.setUp()
        sut = MockNotificationRepository()
        result = []
    }
    
    override func tearDown() {
        sut = nil
        result = nil
        super.tearDown()
    }
    
    func testFetchNotifications_hasAtLeastOneItem() {
        // given
        let expectation = expectation(description: "Notifaction page has at least one notification ")
        expectation.expectedFulfillmentCount = 1
        
        // when
        sut.fetchNotifications { [weak self] result in
            switch result {
            case .success(let page):
                self?.result = page.data
            case .failure(_):
                break
            }
            expectation.fulfill()
        }
        
        // then
        waitForExpectations(timeout: 3.0)
        XCTAssertTrue(result.count > 0)
    }
    
    func testSearchNotificationsByQuery_hasAtLeastOneItem_IfQueryIsValid() {
        // given
        let expectation = expectation(description: "Notifaction page has at least one notification ")
        expectation.expectedFulfillmentCount = 1
        let query = NotificationQuery(text: "Tin nội bộ")
        
        // when
        sut.searchNotificationsBy(query) { [weak self] result in
            switch result {
            case .success(let page):
                self?.result = page.data
            case .failure(_):
                break
            }
            expectation.fulfill()
        }
        
        // then
        waitForExpectations(timeout: 3.0)
        XCTAssertTrue(result.count > 0)
    }
    
    func testSearchNotificationsByQuery_hasNoItems_IfQueryIsInValid() {
        // given
        let expectation = expectation(description: "Notifaction page has at least one notification ")
        expectation.expectedFulfillmentCount = 1
        let query = NotificationQuery(text: "Thích")
        
        // when
        sut.searchNotificationsBy(query) { [weak self] result in
            switch result {
            case .success(let page):
                self?.result = page.data
            case .failure(_):
                break
            }
            expectation.fulfill()
        }
        
        // then
        waitForExpectations(timeout: 3.0)
        XCTAssertTrue(result.count == 0)
    }
}
