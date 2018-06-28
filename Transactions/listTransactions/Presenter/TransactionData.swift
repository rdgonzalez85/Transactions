//
//  TransactionsData.swift
//  Transactions
//
//  Created by Rodrigo Gonzalez on 22/02/2018.
//  Copyright © 2018 Rodrigo Gonzalez. All rights reserved.
//

import Foundation

// Visual reprensetation of a Transaction
struct TransactionData {
    let title: String
    let date: String
    let amount: String?
}

// custom init with Transaction
extension TransactionData {
    init(transaction: Transaction) {
        title = transaction.description
        date = ListTransactionsPresenterFormatter.dateFormatter.string(from: transaction.authorizationDate)
        amount = ListTransactionsPresenterFormatter.currencyFormatter.string(from: NSNumber(value: transaction.amount))
    }
}
