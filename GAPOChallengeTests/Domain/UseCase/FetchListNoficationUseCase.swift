//
//  FetchListNoficationUseCaseTest.swift
//  GAPOChallengeTests
//
//  Created by Nguyen Dinh Hoang on 5/20/22.
//

import XCTest
import RxSwift
import RxCocoa

class FetchListNoficationUseCaseTest: XCTestCase {

    private var repository: NotificationRepository!
    private var notifications: [Notification]!
    private var sut: FetchListNoficationUseCase!
    private var bag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        repository = MockNotificationRepository()
        notifications = []
        sut = DefaultFetchListNoficationUseCase(repository: repository)
        bag = DisposeBag()
    }
    
    override func tearDown() {
        repository = nil
        notifications =  nil
        sut = nil
        bag = nil
        super.tearDown()
    }

    func testExecute_hasAtLeastOneNotification() {
        // given
        let expectation = expectation(description: "Notifaction page has at least one notification ")
        expectation.expectedFulfillmentCount = 1
        
        // when
        sut.execute()
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
    
}
