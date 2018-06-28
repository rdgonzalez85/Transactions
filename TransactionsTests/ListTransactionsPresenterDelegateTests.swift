//
//  ListTransactionsPresenterDelegateTests.swift
//  TransactionsTests
//
//  Created by Rodrigo Gonzalez on 6/28/18.
//  Copyright © 2018 Rodrigo Gonzalez. All rights reserved.
//

import XCTest
@testable import Transactions

class ListTransactionsPresenterDelegateTests: XCTestCase {
    
    var delegate: MockListTransactionsPresenterDelegate!
    var presenterExpectation: XCTestExpectation!
    let delay = 1.0
    
    override func setUp() {
        super.setUp()
        presenterExpectation = expectation(description: "presenter expectation")
        delegate = TestHelper.mockPresenterDelegate
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDataReady() {
        let presenter = TestHelper.mockPresenter
        
        listTransactionsWithPresenter(presenter)
        
        XCTAssertTrue(delegate.dataReadyCalled, "dataReady() should have been called")
    }
    
    func testShowError() {
        let presenter = TestHelper.errorMockPresenter
        
        listTransactionsWithPresenter(presenter)
        
        XCTAssertTrue(delegate.showErrorCalled, "showError() should have been called")
    }
    
    private func listTransactionsWithPresenter(_ presenter: ListTransactionsPresenterProtocol) {
        presenter.listTransactions()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.presenterExpectation.fulfill()
        }
        
        waitForExpectations(timeout: delay + 0.5) { (error) in
            if error != nil {
                XCTFail()
            }
        }
    }
    
}
