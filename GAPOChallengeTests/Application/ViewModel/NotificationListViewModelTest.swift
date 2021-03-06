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
    private let notifications = BehaviorRelay<[NotificationItemViewModel]>(value: [])
    private let bag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        sut = DefaultNotificationListViewModel(factory: DependencyContainer.shared)
        sut.outputs.notifications.asObservable().bind(to: notifications).disposed(by: bag)
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
        XCTAssertTrue((notifications.value.count > 0))
    }
    
    func test_fetchItemsWhenViewWillAppearIWasCalledFirstTime_thenHasEmptyNotifications() {
        // given
        let expectation = expectation(description: "Fetch items when view will appear")
        expectation.expectedFulfillmentCount = 1
        
        // when
        sut.inputs.viewWillAppear()
        expectation.fulfill()

        // then
        waitForExpectations(timeout: 3.0)
        XCTAssertTrue((notifications.value.count == 0))
    }
    
    func test_fetchItemsWhenViewWillAppearIWasCalledSecondTime_thenHasNotifications() {
        // given
        let expectation = expectation(description: "Fetch items when viewWillAppear was called the second time")
        expectation.expectedFulfillmentCount = 2
        
        // when
        sut.inputs.viewWillAppear()
        expectation.fulfill()
        
        sut.inputs.viewWillAppear()
        expectation.fulfill()

        // then
        waitForExpectations(timeout: 3.0)
        XCTAssertTrue((notifications.value.count > 0))
    }
    
    func test_searchItemsByQuery_thenHasAtLeastOneItems_ifQueryIsValid() {
        // given
        let expectation = expectation(description: "Search items with valid query")
        expectation.expectedFulfillmentCount = 1
        let query = "Chu ?????c Minh"
        
        // when
        sut.inputs.didSearch(query: query)
        expectation.fulfill()
        
        // then
        waitForExpectations(timeout: 3.0)
        XCTAssertTrue((notifications.value.count > 0))
    }
    
    func test_WhenBeginSearch_thenShowEmptyItemList() {
        // given
        let expectation = expectation(description: "Show empty list when begin search ")
        expectation.expectedFulfillmentCount = 2
        
        // when
        sut.inputs.viewDidLoad()
        expectation.fulfill()
        
        sut.inputs.didBeginSearch()
        expectation.fulfill()
        // then
        waitForExpectations(timeout: 3.0)
        XCTAssertTrue((notifications.value.count == 0))
    }
    
    func test_WhenBeginSearch_thenCancelSearch_thenShowTheInitialList() {
        // given
        let expectation = expectation(description: "Show the initial list")
        expectation.expectedFulfillmentCount = 3

        // when
        sut.inputs.viewDidLoad()
        expectation.fulfill()

        sut.inputs.didBeginSearch()
        expectation.fulfill()
        
        sut.inputs.didCancelSearch()
        expectation.fulfill()

        // then
        waitForExpectations(timeout: 5.0)
        XCTAssertTrue((notifications.value.count > 0))
    }
    
    func test_searchItemsByQuery_thenHasAtLeastOneItems_ifQueryIsInvalid() {
        // given
        let expectation = expectation(description: "Search items with valid query")
        expectation.expectedFulfillmentCount = 1
        let query = "Khong Ton Tai"
        
        // when
        sut.inputs.didSearch(query: query)
        expectation.fulfill()
        
        // then
        waitForExpectations(timeout: 3.0)
        XCTAssertTrue((notifications.value.count == 0))
    }
    
}
