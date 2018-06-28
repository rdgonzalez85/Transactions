//
//  MockListTransactionsProvider.swift
//  TransactionsTests
//
//  Created by Rodrigo Gonzalez on 28/06/2018.
//  Copyright © 2018 Rodrigo Gonzalez. All rights reserved.
//

import Foundation
@testable import Transactions

class MockListTransactionsProvider: ListTransactionsProvider  {

    func listTransactions(completionHandler: @escaping ListTransactionsProviderResponse) {
        let transactions = TestHelper.getTransactions()
        completionHandler(transactions,nil)
    }
}
