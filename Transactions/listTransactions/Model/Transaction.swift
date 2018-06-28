//
//  Transaction.swift
//  Transactions
//
//  Created by Rodrigo Gonzalez on 6/23/18.
//  Copyright © 2018 Rodrigo Gonzalez. All rights reserved.
//

import Foundation

// for this example we'll create a new Location struct, however it could make sense to create an extension on CLLocation that conforms to the Codable protocol.
struct Location: Codable {
    let latitude: Float
    let longitude: Float

    private enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
    }
}

// make an extension so we don't lose the custom init from struct
extension Location {
    // custom init since latitude and longitude are coming as Strings from the service
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let long = try container.decode(String.self, forKey: .longitude)
        let lat = try container.decode(String.self, forKey: .latitude)
        
        latitude = ListTransactionsModelFormatter.numberFormatter.number(from: lat)?.floatValue ?? 0
        longitude = ListTransactionsModelFormatter.numberFormatter.number(from: long)?.floatValue ?? 0
    }
}

/*
    Model that represents a transaction in the backend
 */
struct Transaction: Codable {
    let amount: Float
    let authorizationDate: Date
    let description: String
    let location: Location?
    let postTransactionBalance: Float
    let settlementDate: Date
    
    private enum CodingKeys: String, CodingKey {
        case amount
        case authorizationDate = "authorisation_date"
        case description
        case location
        case postTransactionBalance = "post_transaction_balance"
        case settlementDate = "settlement_date"
    }

}

// make an extension so we don't lose the custom init from struct
extension Transaction {
    // custom init since amount and posTransactionBalance are coming as Strings from the service
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let stringAmount = try container.decode(String.self, forKey: .amount)
        let stringPostTransactionBalance = try container.decode(String.self, forKey: .postTransactionBalance)
        
        amount = ListTransactionsModelFormatter.numberFormatter.number(from: stringAmount)?.floatValue ?? 0
        postTransactionBalance = ListTransactionsModelFormatter.numberFormatter.number(from: stringPostTransactionBalance)?.floatValue ?? 0
        
        authorizationDate = try container.decode(Date.self, forKey: .authorizationDate)
        description = try container.decode(String.self, forKey: .description)
        do { location = try container.decode(Location.self, forKey: .location) }
        catch { location = nil }
        settlementDate = try container.decode(Date.self, forKey: .settlementDate)
    }
}


