//
//  TestHelper.swift
//  TransactionsTests
//
//  Created by Rodrigo Gonzalez on 28/06/2018.
//  Copyright © 2018 Rodrigo Gonzalez. All rights reserved.
//

import Foundation
@testable import Transactions

class TestHelper {

    static let mockTransaction: Transaction = {
        let location = Location(latitude: 51.505530, longitude: -0.098169)
        let transaction = Transaction(amount: -3.95, authorizationDate: Date(timeIntervalSince1970: 1453380209), description: "Marks & Spencer", location: location, postTransactionBalance: 14.54, settlementDate: Date(timeIntervalSince1970: 1453459701))
        
        return transaction
    }()
    
    
    static func getTransactions() -> Data? {
        let bundle = Bundle.init(for: TestHelper.self)
        
        guard let url = bundle.url(forResource: "Transactions", withExtension: "json") else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch {
            return nil
        }
    }
    
    static let mockInteractor: ListTransactionsInteractorProtocol = {
        let interactor = ListTransactionsInteractor()
        interactor.provider = MockListTransactionsProvider()
        
        return interactor
    }()
    
    static let mockPresenter: (ListTransactionsPresenterProtocol & ListTransactionsTableViewPresenterProtocol) = {
        let interactor = TestHelper.mockInteractor
        let presenter = ListTransactionsPresenter()
        presenter.interactor = interactor
        
        presenter.delegate = TestHelper.mockPresenterDelegate
        
        return presenter
    }()
    
    static let errorMockPresenter: ListTransactionsPresenterProtocol = {
        let presenter = ErrorMockListTransactionsPresenter()
        presenter.delegate = TestHelper.mockPresenterDelegate
        
        return presenter
    }()
    
    static let mockPresenterDelegate: MockListTransactionsPresenterDelegate  = MockListTransactionsPresenterDelegate()
}
