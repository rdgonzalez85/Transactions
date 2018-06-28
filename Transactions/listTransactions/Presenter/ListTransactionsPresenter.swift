//
//  ListTransactionsPresenter.swift
//  Transactions
//
//  Created by Rodrigo Gonzalez on 22/02/2018.
//  Copyright © 2018 Rodrigo Gonzalez. All rights reserved.
//

import Foundation


protocol ListTransactionsPresenterProtocol {
    // the Presenter's interactor
    var interactor: ListTransactionsInteractorProtocol? {get set}
    
    // the Presenter's delegate
    var delegate: ListTransactionsPresenterDelegate? {get set}
    
    // Retrieves the list of transactions
    func listTransactions()
}

// Presenter's delegate method
protocol ListTransactionsPresenterDelegate: NSObjectProtocol {
    // Called when an error must be displayed
    func showError(error:Error)
    // Informs that the data has been retrieved
    func dataReady()
}

// Presenter functions for TableView dataSource
protocol ListTransactionsTableViewPresenterProtocol {
    // returns the number of sections
    func numberOfSections() -> Int
    // returns the number of items for a given section
    func numberOfItemsInSection(_ section: Int) -> Int
    // returns a TransactionData for a given indexPath
    func itemForIndexPath(_ index: IndexPath) -> TransactionData?
}


class ListTransactionsPresenter: ListTransactionsPresenterProtocol {
    var interactor: ListTransactionsInteractorProtocol?
    weak var delegate: ListTransactionsPresenterDelegate?
    var transactions: [Transaction]?

    func listTransactions() {
        guard let interactor = interactor else {
          return
        }

        interactor.listTransactions(completionHandler: { (transactions:[Transaction]?, error: Error?) in
            if let error = error {
                DispatchQueue.main.async {
                    self.delegate?.showError(error: error)
                }
            } else {
                self.transactions = transactions
                DispatchQueue.main.async {
                    self.delegate?.dataReady()
                }
            }
        })
    }
}

extension ListTransactionsPresenter: ListTransactionsTableViewPresenterProtocol {
    func numberOfSections() -> Int {
        guard let transactions = transactions else {
            return 0
        }
        
        return transactions.count > 1 ? 1 : 0
    }

    func numberOfItemsInSection(_ section: Int) -> Int {
        guard let transactions = transactions else {
            return 0
        }
        
        return transactions.count
    }

    func itemForIndexPath(_ index: IndexPath) -> TransactionData? {
        guard let transactions = transactions else {
            return nil
        }
    
        return TransactionData(transaction: transactions[index.row])
    }
}
