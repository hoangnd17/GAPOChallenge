//
//  NotificationListViewModelTest.swift
//  GAPOChallengeTests
//
//  Created by Nguyen Dinh Hoang on 5/20/22.
//

import XCTest
import RxSwift
import RxCocoa

class NotificationListViewModelTest: XCTestCase {

    private var useCase: NotificationsUseCase!
    private var repository: NotificationRepository!
    private var sut: NotificationListViewModel!
    private let reloadDataWithNotifications = BehaviorRelay<[NotificationItemViewModel]>(value: [])
    private let bag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        repository = MockNotificationRepository()
        useCase = MockNotificationsUseCase(repository: repository)
        sut = DefaultNotificationListViewModel(with: useCase)
        sut.reloadData.asObservable().bind(to: reloadDataWithNotifications).disposed(by: bag)
    }
    
    override func tearDown() {
        useCase = nil
        repository = nil
        sut = nil
        super.tearDown()
    }

    
    func test_fetchItemsWhenViewDidLoad_thenHasNotifications() {
        // given
        let expectation = expectation(description: "Fetch items when view didload")
        expectation.expectedFulfillmentCount = 1
        
        // when
        sut.inputs.viewDidLoad()
        expectation.fulfill()

        // then
        waitForExpectations(timeout: 3.0)
        XCTAssertTrue((reloadDataWithNotifications.value.count > 0))
    }
    
    func test_fetchItemsWhenViewWillAppearIWasCalledFirstTime_thenHasEmptyNotifications() {
        // given
        let expectation = expectation(description: "Fetch items when view didload")
        expectation.expectedFulfillmentCount = 1
        
        // when
        sut.inputs.viewWillAppear()
        expectation.fulfill()

        // then
        waitForExpectations(timeout: 3.0)
        XCTAssertTrue((reloadDataWithNotifications.value.count == 0))
    }
    
    func test_fetchItemsWhenViewWillAppearIWasCalledSecondTime_thenHasNotifications() {
        // given
        let expectation = expectation(description: "Fetch items when view didload")
        expectation.expectedFulfillmentCount = 2
        
        // when
        sut.inputs.viewWillAppear()
        expectation.fulfill()
        
        sut.inputs.viewWillAppear()
        expectation.fulfill()

        // then
        waitForExpectations(timeout: 3.0)
        XCTAssertTrue((reloadDataWithNotifications.value.count > 0))
    }
    
}
