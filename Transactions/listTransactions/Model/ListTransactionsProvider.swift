//
//  ListTransactionsProvider.swift
//  Transactions
//
//  Created by Rodrigo Gonzalez on 22/02/2018.
//  Copyright © 2018 Rodrigo Gonzalez. All rights reserved.
//

import Foundation

typealias ListTransactionsProviderResponse = (Data?, Error?) -> Void

protocol ListTransactionsProvider {
    // get the list of transactions
    func listTransactions(completionHandler: @escaping ListTransactionsProviderResponse)
}

enum ListTransactionsProviderError: Error {
    case missingURL
    case connectionError(error:Error)
}

class ListTransactionsNetworkProvider: ListTransactionsProvider {
    var endpointURL: String? 

    func listTransactions(completionHandler: @escaping ListTransactionsProviderResponse) {

        guard let endpointURL = endpointURL, let url = URL(string: endpointURL) else {
            completionHandler(nil, ListTransactionsProviderError.missingURL)
            return
        }

        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { (data, response, error) in

            if let error = error {
               completionHandler(nil, ListTransactionsProviderError.connectionError(error: error))
            } else {
                completionHandler(data, nil)
            }
        }.resume()
    }
}
