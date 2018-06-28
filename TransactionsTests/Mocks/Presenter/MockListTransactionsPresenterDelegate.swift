//
//  MockListTransactionsPresenterDelegate.swift
//  TransactionsTests
//
//  Created by Rodrigo Gonzalez on 6/28/18.
//  Copyright © 2018 Rodrigo Gonzalez. All rights reserved.
//

import Foundation
@testable import Transactions


class MockListTransactionsPresenterDelegate: NSObject, ListTransactionsPresenterDelegate  {
    var showErrorCalled = false
    var dataReadyCalled = false
    
    func showError(error: Error) {
        showErrorCalled = true
    }
    
    func dataReady() {
        dataReadyCalled = true
    }
}
