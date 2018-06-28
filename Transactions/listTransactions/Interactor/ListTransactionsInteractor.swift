//
//  ListTransactionsInteractor.swift
//  Transactions
//
//  Created by Rodrigo Gonzalez on 22/02/2018.
//  Copyright © 2018 Rodrigo Gonzalez. All rights reserved.
//

import Foundation

enum ListTransactionsInteractorError: Error {
    case noData
    case incorrectFormat
}

protocol ListTransactionsInteractorProtocol {
    var provider: ListTransactionsProvider? {get set}
    // get a list of T transactions
    func listTransactions<T: Decodable>(completionHandler: @escaping (([T]?, Error?) -> Void))
}

class ListTransactionsInteractor: ListTransactionsInteractorProtocol {
    var provider: ListTransactionsProvider?

    func listTransactions<T: Decodable>(completionHandler: @escaping (([T]?, Error?) -> Void)) {
        guard let provider = provider else {
            return
        }
        
        provider.listTransactions (completionHandler: { (data: Data?, error: Error?) in
            if let error = error {
                completionHandler(nil, error)
            } else {
                guard let data = data else {
                    completionHandler(nil,ListTransactionsInteractorError.noData)
                    return
                }
            
                do {
                    let decodedData: [T] = try self.decode(data: data)
                    completionHandler(decodedData, nil)
                } catch {
                    completionHandler(nil,ListTransactionsInteractorError.incorrectFormat)
                }
            }
        })
    }
    
    // decode the json data into T objects
    private func decode<T: Decodable>(data: Data) throws -> [T]  {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let decodedData = try decoder.decode([T].self, from: data)
        return decodedData
    }
}
