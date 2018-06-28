//
//  ListTransactionsPresenterFormatter.swift
//  Transactions
//
//  Created by Rodrigo Gonzalez on 6/28/18.
//  Copyright © 2018 Rodrigo Gonzalez. All rights reserved.
//

import Foundation

class ListTransactionsPresenterFormatter {

    // visual formatter for dates
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
    
    // visual formatter for currencies
    static let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        return formatter
    }()
}
