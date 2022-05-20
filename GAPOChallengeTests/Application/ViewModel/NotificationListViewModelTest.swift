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

    private var useCase: FetchListNoficationUseCase!
    private var repository: NotificationRepository!
    private var sut: NotificationListViewModel!
    private let reloadDataWithNotifications = BehaviorRelay<[NotificationItemViewModel]>(value: [])
    private let bag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        repository = MockNotificationRepository()
        useCase = DefaultFetchListNoficationUseCase(repository: repository)
        sut = DefaultNotificationListViewModel(with: useCase)
    }
    
    override func tearDown() {
        useCase = nil
        repository = nil
        sut = nil
        super.tearDown()
    }

    
    func test_fetchItemsWhenViewDidLoad() {
        // given
        let expectation = expectation(description: "Fetch items when view didload")
        expectation.expectedFulfillmentCount = 1
        
        // when
        sut.viewDidLoad()
        sut.items
            .drive(reloadDataWithNotifications)
            .disposed(by: bag)
        
        expectation.fulfill()

        // then
        waitForExpectations(timeout: 3.0)
        XCTAssertTrue((reloadDataWithNotifications.value.count > 0))
    }
}
