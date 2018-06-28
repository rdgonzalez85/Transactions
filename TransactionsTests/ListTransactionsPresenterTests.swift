//
//  ListTransactionsPresenterTests.swift
//  TransactionsTests
//
//  Created by Rodrigo Gonzalez on 6/23/18.
//  Copyright © 2018 Rodrigo Gonzalez. All rights reserved.
//

import XCTest
@testable import Transactions

class ListTransactionsPresenterTests: XCTestCase {
    
    var presenter: (ListTransactionsPresenterProtocol & ListTransactionsTableViewPresenterProtocol)!
    var presenterExpectation: XCTestExpectation!
    let delay = 1.0
    
    override func setUp() {
        super.setUp()
        presenter = TestHelper.mockPresenter
        presenterExpectation = expectation(description: "presenter expectation")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNumberOfSections() {
        listTransactions()
        XCTAssert(presenter.numberOfSections() > 0, "should have at least one section")
    }
    
    func testNumberOfItemsForSection() {
        listTransactions()

        let section = 0
        XCTAssert(presenter.numberOfItemsInSection(section) > 0, "should have at least one item")
    }
    
    func testItemForIndexPath() {
        listTransactions()
        
        let index = IndexPath(item: 0, section: 0)
        let item = presenter.itemForIndexPath(index)
        XCTAssertNotNil(item, "should have an item")
    }
    
    private func listTransactions() {
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
