//
//  DetailViewModelTests.swift
//  SNInterviewTests
//
//  Created by Vignesh Radhakrishnan on 09/05/22.
//  Copyright © 2022 ServiceNow. All rights reserved.
//

import XCTest
@testable import SNInterview

class DetailViewModelTests: XCTestCase {

    private var subject: DetailViewModel!

    override func setUp() {
        super.setUp()
        subject = DetailViewModel(service: MockDetailService())
    }

    func testGetCellViewModelInvalidIndex() {
        XCTAssertNil(subject.getCellViewModel(atIndex: 10))
    }

    func testGetCellViewModelValidIndex() {
        subject.fetchDetails() { result in
            switch result {
            case .success(_):
                XCTAssertNotNil(self.subject.getCellViewModel(atIndex: 1))
            case .failure(_):
                XCTFail()
            }
        }
    }

    func testCellViewModels() {
        subject.fetchDetails() { result in
            switch result {
            case .success(_):
                XCTAssertEqual(self.subject.numberOfItems(), 2)
                XCTAssertEqual(self.subject.getCellViewModel(atIndex: 1)?.name, "test")
                XCTAssertEqual(self.subject.getCellViewModel(atIndex: 1)?.review, "test")
                XCTAssertEqual(self.subject.getCellViewModel(atIndex: 1)?.rating, 1)
            case .failure(_):
                XCTFail()
            }
        }
    }

    func testError() {
        subject = DetailViewModel(service: MockDetailService(error: NSError(domain: NSURLErrorDomain, code: NSURLErrorBadURL, userInfo: [NSLocalizedDescriptionKey: "Unknown error"])))
        subject.fetchDetails() { result in
            switch result {
            case .success(_):
                XCTFail()
            case let .failure(error):
                XCTAssertEqual(error.localizedDescription, "Unknown error")
            }
        }
    }


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
