//
//  ListTransactionsInteractorTests.swift
//  TransactionsTests
//
//  Created by Rodrigo Gonzalez on 28/06/2018.
//  Copyright © 2018 Rodrigo Gonzalez. All rights reserved.
//

import XCTest
@testable import Transactions

class ListTransactionsInteractorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testListTransactions() {
        let interactor = TestHelper.mockInteractor
        
        let interactorExpectation = expectation(description: "interactor list transactions expectation")
        
        interactor.listTransactions { (transactions:[Transaction]?, error: Error?) in
            XCTAssertNil(error, "should not have an error")
            XCTAssertNotNil(transactions, "should have transaction")
            XCTAssert(transactions!.count>0, "should have at least one transaction")
            interactorExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { (error) in
            if error != nil {
                XCTFail()
            }
        }
    }
    
}
