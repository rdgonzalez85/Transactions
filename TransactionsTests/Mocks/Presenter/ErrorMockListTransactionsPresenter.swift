//
//  ErrorMockListTransactionsPresenter.swift
//  TransactionsTests
//
//  Created by Rodrigo Gonzalez on 6/28/18.
//  Copyright © 2018 Rodrigo Gonzalez. All rights reserved.
//

import Foundation
@testable import Transactions

class ErrorMockListTransactionsPresenter: ListTransactionsPresenterProtocol {
    var interactor: ListTransactionsInteractorProtocol?
    
    var delegate: ListTransactionsPresenterDelegate?
    
    enum MockError: Error {
        case error
    }
    
    func listTransactions() {
        delegate?.showError(error: MockError.error)
    }
}
